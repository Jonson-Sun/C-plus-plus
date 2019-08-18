#   
#	一些比较常用的函数
#

#============================================
utf-8变长编码-> 可直接索引的[]存储?
  使用方式:
	substr("阿三科技的符号i阿斯顿飞呢",3,-2)
	substr("阿三科技的符号i阿斯顿飞呢",3,7)
========================================#

function substr(str::String,start_idx::Int,end_idx::Int)
	#半开半闭区间[start,end) 没法表示索引到结尾
	#使用[start,end] 更附和julia的原则:从1开始
	if end_idx >length(str) @error "BoundsError 索引越界";return end
	char_list=[];
	tmp=""
	
	for item in str		push!(char_list,item)	end
	if end_idx<0 	end_idx=(length(char_list)+end_idx+1) end
	if start_idx>end_idx	return "" end   #排除错误参数
	for item in char_list[start_idx:end_idx]
		tmp=tmp*item
	end
	#@info "$(tmp)"
	return tmp
end


#=======================================
	类型转换:  Int64('苏') ->33487
		String -> Int32 -> bitstring
		Int->Float32 ->
====================================#
function str2array(str::String)
	tmp=[]
	for item in str
		push!(tmp,item)
	end
	return tmp
end
function str2int_array(str::String)
	tmp=Array{Int32,1}()  #不要忘了维度信息
	for item in str
		push!(tmp,Int32(item))
	end
	return tmp
end
function str2int_str(str::String)
	tmp=""
	for item in str
		tmp=tmp*repr(Int(item))
	end
	return tmp
end
function str2BigInt(str::String)
	#十进制 str->BigInt转换
	table=Set(['0','1','2','3','4','5','6','7','8','9'])
	for item in str
		@assert item in table "$(item)不是十进制数字"
	end
	return parse(BigInt,str)
	#return big"1234645675643523412423123456457"
end

#
#	3x+1 问题
#从任意一个正整数开始，重复对其进行下面的操作：
#	如果这个数是偶数，把它除以 2 ；
#	如果这个数是奇数，则把它扩大到原来的 3 倍后再加 1 。
#	序列是否最终总会变成 4, 2, 1, 4, 2, 1, … 的循环？
#{不是任意正整数,还要大于三}
#{意味着所有的tmp都不能是2^n}
#问题转换{2^n在上述规则{相反}下,能不能覆盖所有的正整数?}
#
function ulam_quest(tmp::BigInt)
	i::Int=1
	while tmp!=1 #只要出现1就会421循环
		if tmp%2==1 
			tmp=3*tmp+1
		else
			tmp/=2
		end
		#print("$tmp ")
		if i > 10000_0000_0000
			@info "循环超过万亿"
			return false
		else
			i+=1
		end
	end
	return true
end

#=============================================
		本文件的测试函数
	注意:所有的测试函数都应该有进度条
=========================================#
function test()
	count=1
	start=1_0000_0000
	endp =2_0000_0000
	for i=start:endp
		num::BigInt=i
		if ulam_quest(num)
			#print("\n $num Y")
			#println()
		else 
			print("\n $num N")
			break
		end
		if i%(endp/100)==0 @info "$count %";count+=1; end
	end
return true
	
	substr("阿三科技的符号i阿斯顿飞呢",3,-2)
	substr("阿三科技的符号i阿斯顿飞呢",3,7)

	asd="阿三健康的符合牛asdf郎我烦恼"
	@show str2array(asd)
	@show str2int_array(asd)
	@show str2int_str(asd)
	@show str2BigInt(str2int_str(asd))
	@show str2BigInt("123343245e")
end
test()

#解方程 cos2x + cos22x + cos23x = 1 (1962年国际数学奥林匹克IMO第4题)
#答案 pi/4

#湍流，又称为乱流、紊流或扰流
#当流速很小时，流体分层流动，互不混合，称为层流

#曲线的内接正方形
# 证明或推翻，在平面中的任意一条简单封闭曲线上，总能找到四个点，它们恰能组成一个正方形。


#环形跑道难题
#有一个环形跑道，总长为 1 个单位。n 个人从跑道上的同一位置出发，沿着跑道顺时针一直跑下去。每个人的速度都是固定的，但不同人的速度不同。证明或推翻，对于每一个人，总会有一个时刻，他与其他所有人的距离都不小于 1/n

#排序问题加强版
#有 n 个盒子，从左至右依次编号为 1, 2, …, n 。第 1 个盒子里放两个编号为 n 的小球，第 2 个盒子里放两个编号为 n – 1的小球，以此类推，第 n 个盒子里放两个编号为 1 的小球。每一次，你可以在相邻两个盒子中各取一个小球，交换它们的位置。为了把所有小球放进正确的盒子里，最少需要几次交换？

#多面体的展开
#证明或推翻，总可以把一个凸多面体沿着棱剪开，展开成一个简单的平面多边形。

#用平面镜拼成的多边形
# 证明或推翻，对于任意一个内壁全是镜面的多边形，总能在里面找到一个点，使得位于这个点的光源可以照亮整个多边形内部

#Thrackle 猜想
#如果一个图中，每条边都与其它所有边相交恰好一次（顶点处相接也算相交），这个图就叫做一个 thrackle 。问，是否存在边数大于顶点数的 thrackle 图？

#Venn 图
#是否随便什么样的 n 个集合的 Venn 图都可以扩展到 n + 1 个集合{的venn图}呢


#令 U 是一个有限集，S1 , S2 , … , Sn 都是 U 的非空子集，它们满足任意多个集合的并集仍然在这些集合里。证明，一定能找到某个元素，它出现在了至少一半的集合里。




#计算杨辉三角数列 1 1开始
#保加利亚单人纸牌游戏（Bulgarian solitaire）
#取出 45 张牌，然后把它们随意分成若干堆。接下来，从每一堆里各取一张牌，叠在一起形成一堆新的牌。不断这样做下去，如果某个时候桌面上正好有 9 堆牌，并且各堆牌数分别为 1, 2, 3, 4, …, 9 ，你就获胜了