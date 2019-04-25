
### 다음 실시간 검색 수집
# 패키지 불러오기
library(tidyverse)
library(httr)
library(rvest)


# url 복사
'https://www.daum.net/'

# HTTP 요청 
res <- GET(url = 'https://www.daum.net/')

# 응답 결과 확인 
print(x = res)


# 실시간 검색어 추출 
searchWords <- res %>% 
  read_html() %>% 
  html_nodes(css = 'div.realtime_part > ol > li > div > div:nth-child(1) > span.txt_issue > a') %>% 
  html_text(trim = TRUE)

# 실시간 검색어 추
print(x = searchWords)


## End of Document
