# verilog
ベクトルプロセッサを作るつもり。

----

## 今更の要件定義

- 16bit x 64 x 64 の行列演算器　-> リソース足りてないので16 x 32 x 32に（SRAM使えばまだ行けるかも？）
- コア数　16　シストリックスにしてパイプライン化　->リソース（ｒｙ　4個で…
- 命令セットなし。OISCで行きたい。（未定）
- ホストとのインターフェイスは多分イーサネット。
- コントローラーはめんどくさいし、Zynq内のARMを使いたい…（動作クロック圧倒的に早いから多分大丈夫白目）