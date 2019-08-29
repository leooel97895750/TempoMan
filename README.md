# TempoMan

FPGA<br>
將verilog燒進FPGA，控制按鈕與8X8LED面板來進行節奏遊戲<br>
<img src="https://raw.githubusercontent.com/leooel97895750/TempoMan/master/111575.jpg" width="50%" height="50%">

### 功能介紹
<img src="https://raw.githubusercontent.com/leooel97895750/TempoMan/master/1.jpg" width="70%" height="70%">

* 中間四個按鈕控制角色
* 上方LED顯示Combo數(累積的節奏數)
* 右上方的七段顯示器顯示角色的血量
* 右邊的8X8LED矩陣面板顯示遊戲畫面
* 下方的蜂鳴器發出一定節奏的聲音

### 遊戲介紹
<img src="https://raw.githubusercontent.com/leooel97895750/TempoMan/master/2.jpg" width="40%" height="40%">
我們的玩家是圖中綠色的部分，上下兩條藍色線會隨著節奏閃爍，只要在對的時機按下按鍵，角色就會有所動作<br>
按鍵有四個，有左至右分別叫做ABCD，不同組合模式會有不同效果<br>

* DDDB: 前進
* DDDA: 跳躍(閃敵人子彈用)
* CCCB: 補滿血(限用一次)
* CCCA: 發射子彈

### 節奏機制
玩家必須完整的按四次有意義的按鍵組合才會使角色動作，若其中任何一下沒在節奏上則必須重新再按一次，上方的LED燈會顯示目前累積的節奏次數<br>
因此本遊戲的樂趣在於面對特定情況下選擇適合的模式且必須對上節奏，讓玩家有放出技能的成就感和對上節奏的流暢感<br>

### 製作心得
我覺得最難的部分在時脈的運用，透過利用時脈來除頻，包括子彈射速、節奏頻率，其中較難的是角色的跳躍要有加速度<br>
還有各種要考量先後順序的碰撞，也要避免前一個動作還沒做完就進入下一個指令<br>
總之，透過verilog來控制各個硬體，達成實際可以遊玩的成品，這個過程非常有成就感也很有趣<br>
遊玩影片: https://raw.githubusercontent.com/leooel97895750/TempoMan/master/111573.t.mp4
