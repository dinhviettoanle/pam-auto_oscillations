function unfolded=unfold(buffer, ind)
    unfolded=circshift(buffer, length(buffer)ind);
end