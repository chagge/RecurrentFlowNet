function layer = occflow_wrapper(g, layer, resize_rate)

attenuate_first = 1;

[layer.predvec, layer.prev_gridvec, layer.context] ...
    = occflow_mex( ...
    layer.curr_input, layer.prev_gridvec, layer.context ...
    , layer.nei.nei_idx, layer.nei.nei_weight, layer.nei.filnter_n, layer.nei4u.nei_idx, layer.nei4u.nei_weight, layer.nei4u.filnter_n ...
    , layer.occval , layer.minthreshold, layer.maxthreshold, layer.reinitval ...
    , layer.intensifyrate, layer.nocc_attenuaterate, layer.unknown_attenuaterate, layer.sigm_coef ...
    , attenuate_first);

% covert prev to binary vector
layer.binpredvec  = double(layer.predvec > layer.pred_threshold);
% convert binary vector to binary matrix
layer.binpredmtx  = reshape(layer.binpredvec, g.ny, g.nx);
% resize binary matrix to smaller matrix (resize_rate*100 %)
layer.smallmtx    = imresize(layer.binpredmtx, resize_rate, 'bilinear');
% covert resized matrix to binary matrix
layer.binsmallmtx = double(layer.smallmtx > layer.bin_threshold);

