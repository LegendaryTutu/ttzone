import numpy as np
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

def cal_recommend_index(k,
                        user_id,
                        item_id,
                        freq_matrix,user_similar_matrix
                       ):
    item_id_col  = freq_matrix.loc[:, item_id]
    similar_id_values = user_similar_matrix.loc[user_id, :].sort_values()[-(k+1):-1]
    similar_id_values = similar_id_values.sort_index()
    score = item_id_col[similar_id_values.index]
    
    if score.sum() == 0:
        return 0
    
    score_above_0 = (score > 0).astype(int)
    above_score = similar_id_values.dot(score)
    below_score = similar_id_values.dot(score_above_0)
    return above_score/below_score


def cal_recommend(freq_matrix, k = 2):
    user_similar_matrix = cosine_similarity(freq_matrix)
    user_similar_matrix = pd.DataFrame(user_similar_matrix,
                                   index = freq_matrix.index,
                                   columns = freq_matrix.index
                                  )
    predict_matrix = pd.DataFrame(np.zeros(freq_matrix.shape),
                              index = freq_matrix.index,
                              columns = freq_matrix.columns
                             )
    
    for user_id in freq_matrix.index:
        for item_id in freq_matrix.columns:
            if freq_matrix.loc[user_id,item_id] == 0 :
                final_score = cal_recommend_index(k = 2,
                                                  user_id = user_id,
                                                  item_id = item_id,
                                                  freq_matrix = freq_matrix, 
                                                  user_similar_matrix = user_similar_matrix)
                predict_matrix.loc[user_id, item_id] = final_score
                
    predict_freq_matrix = np.around(predict_matrix,2)
    final_recommend_df = predict_freq_matrix.stack().reset_index()
    final_recommend_df = final_recommend_df.rename({0 : 'recommend_score'}, axis = 1)
    final_recommend_df = final_recommend_df[final_recommend_df['recommend_score'] != 0]
    final_recommend_df = final_recommend_df.sort_values(['user', 'recommend_score'], ascending = [True, False])
    
    return final_recommend_df