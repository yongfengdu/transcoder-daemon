#!/bin/bash
# This script will create several destination dir, like "h264", "mpeg2",
# under /mnt/shard dir. If you want to transcode a media file to one format,
# use "mpeg2" for example, cp the file to /mnt/shard/mpeg2 dir, then it will
# be transcoded to mpeg2 automatically and place in the same dir.
#set -x

root_dir='/mnt/shared/'
declare -A file_ext_to_decoder_type=( ["h265"]="h265" ["265"]="h265" ["h264"]="h264" ["264"]="h264" ["mpeg2"]="mpeg2" ["vc1"]="vc1" ["mvc"]="mvc" ["jpeg"]="jpeg" ["vp9"]="vp9" )
all_encoder_type=("h265" "h264" "mpeg2" "mvc" "jpeg" "raw")

function transcode()
{
    encoder_type=$1
    work_dir=$root_dir$encoder_type

    for file in $work_dir/*
    do
        if [ ! -f "$file" ]; then
            continue
        fi

        filename=${file%.*}
        extension=${file##*.}
        decoder_type=${file_ext_to_decoder_type[${extension}]}
        output_file="${filename}.${encoder_type}"
        if [ -f "$output_file" ]; then
            continue
        fi
        input_file="${file}"
	echo "Transcoding to $output_file"
        if [ ! -f "${output_file}" ]; then
            su - -c "sample_multi_transcode -i::${decoder_type} ${input_file} -o::${encoder_type} ${output_file}"
        fi
    done
}

function transcode_all_types()
{
    for i in "${all_encoder_type[@]}"
    do
        transcode $i
    done
}

# Create trans-code dest dir under working dir for each encoder type
for i in "${all_encoder_type[@]}"
do
    mkdir -p $root_dir$i
done

while true
do
    transcode_all_types
    sleep 10
done

