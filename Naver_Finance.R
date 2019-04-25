
# --------------------------------------------------------------------------------
# 다음 메인 페이지에서 실시간 검색어 수집
# --------------------------------------------------------------------------------

# 필요한 패키지를 불러옵니다. 
library(tidyverse)
library(httr)
library(rvest)


# 다음 실시간 검색어가 포함된 웹 페이지의 URI를 복사하여 붙입니다. 
'https://finance.naver.com/sise/sise_index.nhn?code=KOSPI'

# HTTP 요청을 실행합니다. 
res <- GET(url = 'https://finance.naver.com/sise/sise_index.nhn?code=KOSPI')

# 응답 결과를 확인합니다. 
print(x = res)

# 실시간 검색어를 추출합니다. 
searchWords <- res %>%
  read_html(encoding = "euc-kr") %>% 
  html_nodes(css = '#contentarea_left > div.box_top_sub > div > div.subtop_sise_detail > table') %>%
  html_table(fill = TRUE)

# 실시간 검색어를 출력합니다. 
as.data.frame(searchWords)


## End of Document


