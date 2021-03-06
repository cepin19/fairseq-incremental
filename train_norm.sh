rm checkpoints/*
export PYTHONPATH=//home/large/data/models/marian/encz_exp/fairseq-multisrc
export CUDA_VISIBLE_DEVICES=1
python3 fairseq_cli/train.py \
    data-bin/encs_5M_norm \
    --arch transformer --share-decoder-input-output-embed  \
    --optimizer adam --adam-betas '(0.9, 0.98)' --clip-norm 0.0 \
    --lr 3e-4 --lr-scheduler inverse_sqrt --warmup-updates 16000 --weight-decay 0.0001 \
    --criterion label_smoothed_cross_entropy --label-smoothing 0.1 \
    --max-tokens 600 \
    --log-interval 100 \
    --save-dir model_norm/ \
    --keep-last-epochs 1 \
    --keep-best-checkpoints 1 \
    --validate-interval-updates 10 \
    --eval-bleu \
    --eval-bleu-args '{"beam": 5, "max_len_a": 1.2, "max_len_b": 10}' \
    --eval-bleu-remove-bpe sentencepiece \
    --eval-bleu-print-samples \
    --best-checkpoint-metric bleu --maximize-best-checkpoint-metric \
    --seed 1111 \
    --tensorboard-logdir tb_norm/

