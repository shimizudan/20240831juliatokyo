### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# ╔═╡ 8acc204e-896e-11ed-1251-438ce5d793cb
begin
using PlutoUI
TableOfContents(title="高校数学とjulia")
end

# ╔═╡ 40c7a0df-dbc1-4703-baeb-c1854669f195
let

	#みかん1個✕円、りんご1個y円
	#Aさんの所持金は30x＝18y 円
	#りんごをn個買うと、みかんは24-n個
	# 30x=（24-n） x+n30x/18
	#n + (24-n) *30/18 -30 =0
		
	using SimplePolynomials
	n = getx()
	N = roots(n*30/18+(24-n)-30)[1] |> Int64
	println("りんごは$(N)個")

end


# ╔═╡ f176d67e-bb13-43c7-8557-9b005945f4f9
using Combinatorics

# ╔═╡ 866207ab-db72-4220-b1c7-9b73d0ac91e8
md"""
# はじめに

> ![](https://shimizudan.github.io/20240831juliatokyo/shimizu.png)

"""

# ╔═╡ fcbaf6f4-5f24-448d-937b-58374362c18a
md"""
## 最近の取り組み

**「数学を考えるときにJulia言語を使うととてもいい感じ！」**をキャッチフレーズに，主にXなどで発信・情報交換をしています。今日はその中から4つ紹介します。

> - **鈴木伸介さんとの交流**
> - **合法うどん決定トーナメント**
> - **高校数学の統計について**
> - **Zenn Booksの紹介**

"""

# ╔═╡ f54dbff1-c1ab-47a2-bead-1484c97ecae3
md"""

# 鈴木伸介さんとの交流

X上で鈴木伸介さん[(@suzzukes)](@suzzukes)が土日に数学の問題を出してくれます。なんとなく，julia言語使って解くことが習慣になってしまいました。いくつかやりとりを紹介します。

![](https://shimizudan.github.io/20240831juliatokyo/suzuki.png)


## 2024年4月28日

![](https://shimizudan.github.io/20240831juliatokyo/428m.png)


![](https://shimizudan.github.io/20240831juliatokyo/428.png)


"""

# ╔═╡ 7a57522b-c172-48fc-b9f7-627af0894508
let
	#2024/4/28
	x = 1
	while x < 1000 #まあ1000くらいまでで大丈夫かな。
	    k = 0
	    for j = x:x+10
	        if j |> iseven 
	            k += j
	        else k -= j
	        end
	    end
	    if k == 19
	        println("$(x)〜$(x+10)の11個の自然数。最大の自然数は$(x+10)")
	        break
	    end
	    x += 1
	end

end

# ╔═╡ 1c20fb8c-5cd2-4c2d-8e42-7125001bfff1
md"""

## 2024年7月7日

![](https://shimizudan.github.io/20240831juliatokyo/707m.png)


![](https://shimizudan.github.io/20240831juliatokyo/707.png)


"""

# ╔═╡ 1da84535-b41e-4f8e-886a-38581fcaab9b
let
	lcm(21,15)//gcd(104,182)
end

# ╔═╡ 2d3aeaab-c3ab-48b8-87af-031634b60c5d
md"""

## 2024年8月4日

![](https://shimizudan.github.io/20240831juliatokyo/804m.png)


![](https://shimizudan.github.io/20240831juliatokyo/804.png)


"""

# ╔═╡ a0e71c8c-9b5e-4406-ac51-9d43bd71ab75
md"""

## 2024年8月17日

![](https://shimizudan.github.io/20240831juliatokyo/817m.png)


![](https://shimizudan.github.io/20240831juliatokyo/817.png)


"""

# ╔═╡ 9b6bc15e-ffe8-4f30-bdaf-910293f2e181
let
	[(x,y) for x = 1:33 , y = 1:14 if 3x+7y == 100]
end

# ╔═╡ cb86a55b-a5d6-40c0-9d0a-5a4528f34d67
md"""

# 合法うどん決定トーナメント

「合法うどん決定トーナメント」とは数学コミュニティー「数学デー」の中で話題となり，2024/8/1にポストされました。

[https://x.com/sugaku_day/status/1818672471383720013](https://x.com/sugaku_day/status/1818672471383720013)


![](https://shimizudan.github.io/20240831juliatokyo/1.jpeg)


## n=3のうどん

![](https://shimizudan.github.io/20240831juliatokyo/n3.jpg)

## n=4のうどん


![](https://shimizudan.github.io/20240831juliatokyo/n4.jpg)


## n=5のうどん


![](https://shimizudan.github.io/20240831juliatokyo/n5.png)


## n=6のうどん


![](https://shimizudan.github.io/20240831juliatokyo/n6.png)


## カタラン数？

- 数の並びは$1,1,2,5,14,42,...$となり，これはカタラン数ですね，
- [@aoki_taichi](https://x.com/aoki_taichi)さんのXへの投稿を参考にしました。
- [https://x.com/aoki_taichi/status/1819035623648587968](https://x.com/aoki_taichi/status/1819035623648587968)

![](https://shimizudan.github.io/20240831juliatokyo/k.jpg)


"""

# ╔═╡ 922cae3f-67e5-48d6-88f8-9b5900bd6b5d
md"""

## Julia のコード

>- カタラン数のリストからうどんの配置パターンを作成
>- 逆に配置パターンからカタラン数のリストを決定する

"""

# ╔═╡ 6205b1fc-ec3a-4b7b-b690-851f151ada1e
md"""

## soi関数

- うどんを合成する関数です。

"""

# ╔═╡ 945e3c37-3442-4810-809e-97571b3e3939
#soi関数
function soi(A::Vector,B::Vector)
	X = B
	l = length(A)
	for i = 1:l
		pushfirst!(X,A[i])
	end
	X
end

# ╔═╡ ff4ac6f3-c4db-44ff-bd02-32a02996d60c
#soi関数の例
soi([1],[2])

# ╔═╡ cc3f6a2b-ffa0-4d33-a8fb-a21faae3cd4d
soi([1],[2,3])

# ╔═╡ d2b9d37c-4ac0-4c3f-badb-b082e8b6b288
soi([1,2],[3])

# ╔═╡ bdf627ec-c230-45c3-991b-ed384af4ddb2
soi([1,2,3],[4])

# ╔═╡ f200053f-f7ff-45d1-90b8-2bc6689e8340
md"""
## カタラン数のリストチェック
- 1と2が同数あるリストを用いて，左端からどの番まででも（1の個数）≧（2の個数）となっているかチェックします。

"""

# ╔═╡ 384ee2f2-f4c6-4d98-94a2-d064c7dda871
#左端からどの番まででも（1の個数）≧（2の個数）となっているかチェック
function catalan_check(sequence::Vector{Int})
    count1 = 0
    count2 = 0
    for i in sequence
        if i == 1
            count1 += 1
        elseif i == 2
            count2 += 1
        end
        if count2 > count1
            return false
        end
    end
    return true
end

# ╔═╡ c8509e6b-c898-47e4-b1ab-990952a5a6f0
#チェック例
catalan_check([1,1,1,1,2,2,2,2])

# ╔═╡ c0356cd0-f51c-4c30-88d3-9588c7815a9c
catalan_check([1,2,1,1,2,1,2,2])

# ╔═╡ 38d57f11-8f46-40df-a20c-47efe1a681c4
catalan_check([2,2,2,2,1,1,1,1])

# ╔═╡ 7e0a968c-985f-44c2-9997-62171fa8ed1d
catalan_check([1,2,2,1,2,1,1,2])

# ╔═╡ 1a7b643e-99d2-4720-986b-e8dbb359f36a
md"""

## カタラン数のリスト作成
- 1がn個，2がn個を一列に並べたリストを（1の個数）≧（2の個数）でチェック
- 総数はカタラン数C(n+1)である
- `Combinatorics.jl`を利用します。


"""

# ╔═╡ 223f3f33-7c55-4d9d-a33c-e210baf5ed0b
#1がn個，2がn個を一列に並べたリストを（1の個数）≧（2の個数）でチェック
#総数はカタラン数C(n+1)である
function catalan_list(n)
    X = [i for i = 1:2*n]
    Z = []
    for  x in combinations(X,n)
        Y = ones(Int64,2*n)
        for i in x
            Y[i] = 2
        end
        push!(Z,Y)
    end
    filter(catalan_check, Z)
end

# ╔═╡ 94d20cc9-b738-4a79-ad44-b2b4b2616ff2
#n=4の時のカタラン数のリスト
catalan_list(4)

# ╔═╡ 2aeb36da-85f9-4e7c-affd-5d9bc30628d3
md"""

## うどんの配列作成（soi_seq関数）
- カタラン数のリストからsoi関数で変換します。


"""

# ╔═╡ d6844c95-210e-45d9-a133-e1f60f9c67ff
#カタラン数のリストからsoi関数で変換
function soi_seq(X::Vector)
    l = length(X)
    m = l//2 +1|> Int64
    P = [[i] for i = 1:m]
    count1 = 0
    count2 = 0
    while l >0
        if X[l] == 1
            A = soi(P[m-count2],P[m-count2+1])
            deleteat!(P, m-count2)
            deleteat!(P, m-count2)
            insert!(P,  m-count2,A)
            count1 += 1
        elseif X[l] == 2
            count2 += 1
        end
        l -= 1
    end
    X => P[1]
end

# ╔═╡ 3a42f6f8-0624-4c29-842f-e62b30181d48
#n=4でチェック
for i  ∈ catalan_list(4)
    @show soi_seq(i)
end

# ╔═╡ 28052d2d-a97b-4fb2-b5a5-3132e19a19c0
md"""

##  soi_seqの逆関数

- 結局，アルゴリズムはよくわからなかったです。

- 関数は１対1だったので，ペアのリストを作ってチェックしました。

- １対1は明らかではなかったのですが，一応確認は取れています。



"""

# ╔═╡ 5108e109-4751-4a31-94c6-3bb171f585d8
# soi_seqの逆変換を行う関数
function inverse_soi_seq(sequence::Vector)
    n = length(sequence) -1
    
    # カタラン数リストを生成
    catalan_seqs = catalan_list(n)
    
    # 与えられたシーケンスがカタラン数リストに対応するかチェック
    for seq in catalan_seqs
        _, transformed = soi_seq(seq)
        if transformed == sequence
            return seq
        end
    end
    
    return "対応するカタラン数のリストはない"
end

# ╔═╡ e8e30cca-d17f-4914-b301-725ed65e6105
#逆変換の例
inverse_soi_seq([1,2,4,3,5,6])

# ╔═╡ 08291e92-0e86-440d-8253-89bf45c3fb94
inverse_soi_seq([1,2,4,3,6,5])

# ╔═╡ fa99bdb6-4853-49f6-be68-20e6ceb4cf39
inverse_soi_seq([1,2,3,4,6,5])

# ╔═╡ 4bd19da1-ddd1-4ae5-b5b4-f722bc4c7b74
inverse_soi_seq([2,1,3,4,5,6])

# ╔═╡ 13dff097-eaed-4207-8aeb-12f667dc8bba
md"""

# 高校数学の統計について

大澤裕一さん[(@HirokazuOHSAWA)](https://x.com/HirokazuOHSAWA)とは統計の話題についてXで交流があります。現在の高校生は数学Bで「統計的な推測」を学習します。以前と異なる点は「今年の高校3年生が受ける共通テストで多くの生徒が統計的な推測を選択する。」ということです。後4年経つと，多くの統計リテラシーを持つ方々が社会に出てくるのではないでしょうか。（統計教えて欲しいです。。。）今回は，大澤裕一さんからの問題を少し発展させて考えた経過をご紹介します。


"""

# ╔═╡ ef201ffb-5af5-4a5d-9c29-02d27ffcdd7b
md"""

# Zenn Booksの紹介

私自身，勤務校で数学を担当していますが，「Julia言語使って数学の問題を考えるとどうなるのだろう？」ということに関心があります。高校数学の「場合の数」「確率」という分野の定期テストの問題を題材にJulia言語を用いて考えてみました。体感ですが，「julia言語を用いて数学の問題を考えると，考え方が拡張され，自由になる」と感じました。この2つの「Zenn Books」にまとめました。少しご紹介します。


[https://zenn.dev/dannchu/books/f2fe475efb35dd]
(https://zenn.dev/dannchu/books/f2fe475efb35dd)

![](https://shimizudan.github.io/20240831juliatokyo/book1.png)


[https://zenn.dev/dannchu/books/19354174fa5f25](https://zenn.dev/dannchu/books/19354174fa5f25)


![](https://shimizudan.github.io/20240831juliatokyo/book2.png)

"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Combinatorics = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
SimplePolynomials = "cc47b68c-3164-5771-a705-2bc0097375a0"

[compat]
Combinatorics = "~1.0.2"
PlutoUI = "~0.7.59"
SimplePolynomials = "~0.2.17"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "92272630e867b1821d74684ea71aeb25ddc66623"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "a33b7ced222c6165f624a3f2b55945fac5a598d9"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.7"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.IntegerMathUtils]]
git-tree-sha1 = "b8ffb903da9f7b8cf695a8bead8e01814aa24b30"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.Mods]]
git-tree-sha1 = "924f962b524a71eef7a21dae1e6853817f9b658f"
uuid = "7475f97c-0381-53b1-977b-4c60186c8d62"
version = "2.2.4"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.Multisets]]
git-tree-sha1 = "8d852646862c96e226367ad10c8af56099b4047e"
uuid = "3b2b4ff1-bcff-5658-a3ee-dbcf1ce5ac09"
version = "0.4.4"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

[[deps.Polynomials]]
deps = ["LinearAlgebra", "RecipesBase", "Requires", "Setfield", "SparseArrays"]
git-tree-sha1 = "1a9cfb2dc2c2f1bd63f1906d72af39a79b49b736"
uuid = "f27b6e38-b328-58d1-80ce-0feddd5e7a45"
version = "4.0.11"

    [deps.Polynomials.extensions]
    PolynomialsChainRulesCoreExt = "ChainRulesCore"
    PolynomialsFFTWExt = "FFTW"
    PolynomialsMakieCoreExt = "MakieCore"
    PolynomialsMutableArithmeticsExt = "MutableArithmetics"

    [deps.Polynomials.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    FFTW = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
    MakieCore = "20f20a25-4f0e-4fdf-b5d1-57303727442b"
    MutableArithmetics = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "cb420f77dc474d23ee47ca8d14c90810cafe69e7"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.6"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

[[deps.SimplePolynomials]]
deps = ["Mods", "Multisets", "Polynomials", "Primes"]
git-tree-sha1 = "7063828369cafa93f3187b3d0159f05582011405"
uuid = "cc47b68c-3164-5771-a705-2bc0097375a0"
version = "0.2.17"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─8acc204e-896e-11ed-1251-438ce5d793cb
# ╟─866207ab-db72-4220-b1c7-9b73d0ac91e8
# ╟─fcbaf6f4-5f24-448d-937b-58374362c18a
# ╟─f54dbff1-c1ab-47a2-bead-1484c97ecae3
# ╠═7a57522b-c172-48fc-b9f7-627af0894508
# ╟─1c20fb8c-5cd2-4c2d-8e42-7125001bfff1
# ╠═1da84535-b41e-4f8e-886a-38581fcaab9b
# ╟─2d3aeaab-c3ab-48b8-87af-031634b60c5d
# ╠═40c7a0df-dbc1-4703-baeb-c1854669f195
# ╟─a0e71c8c-9b5e-4406-ac51-9d43bd71ab75
# ╠═9b6bc15e-ffe8-4f30-bdaf-910293f2e181
# ╠═cb86a55b-a5d6-40c0-9d0a-5a4528f34d67
# ╠═922cae3f-67e5-48d6-88f8-9b5900bd6b5d
# ╟─6205b1fc-ec3a-4b7b-b690-851f151ada1e
# ╠═945e3c37-3442-4810-809e-97571b3e3939
# ╠═ff4ac6f3-c4db-44ff-bd02-32a02996d60c
# ╠═cc3f6a2b-ffa0-4d33-a8fb-a21faae3cd4d
# ╠═d2b9d37c-4ac0-4c3f-badb-b082e8b6b288
# ╠═bdf627ec-c230-45c3-991b-ed384af4ddb2
# ╟─f200053f-f7ff-45d1-90b8-2bc6689e8340
# ╠═384ee2f2-f4c6-4d98-94a2-d064c7dda871
# ╠═c8509e6b-c898-47e4-b1ab-990952a5a6f0
# ╠═c0356cd0-f51c-4c30-88d3-9588c7815a9c
# ╠═38d57f11-8f46-40df-a20c-47efe1a681c4
# ╠═7e0a968c-985f-44c2-9997-62171fa8ed1d
# ╟─1a7b643e-99d2-4720-986b-e8dbb359f36a
# ╠═f176d67e-bb13-43c7-8557-9b005945f4f9
# ╠═223f3f33-7c55-4d9d-a33c-e210baf5ed0b
# ╠═94d20cc9-b738-4a79-ad44-b2b4b2616ff2
# ╟─2aeb36da-85f9-4e7c-affd-5d9bc30628d3
# ╠═d6844c95-210e-45d9-a133-e1f60f9c67ff
# ╠═3a42f6f8-0624-4c29-842f-e62b30181d48
# ╠═28052d2d-a97b-4fb2-b5a5-3132e19a19c0
# ╠═5108e109-4751-4a31-94c6-3bb171f585d8
# ╠═e8e30cca-d17f-4914-b301-725ed65e6105
# ╠═08291e92-0e86-440d-8253-89bf45c3fb94
# ╠═fa99bdb6-4853-49f6-be68-20e6ceb4cf39
# ╠═4bd19da1-ddd1-4ae5-b5b4-f722bc4c7b74
# ╠═13dff097-eaed-4207-8aeb-12f667dc8bba
# ╠═ef201ffb-5af5-4a5d-9c29-02d27ffcdd7b
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
