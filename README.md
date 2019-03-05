# CreatVCDemo
一个通过 StoryBoard 快速创建ViewController的方式, 主要为了解耦 StoryBoard 
## iOS StoryBoard 优雅创建控制器方式

我的项目中使用到了**StoryBoard**, 我也是喜欢上了这种创建页面的方式, 所见即所得, 每当产品让我改页面的时候, 我都说分分钟就好. 不用在一坨代码中找一个label, 然后修改其颜色, 改颜色几秒钟, 找代码却找了两分钟.

### StoryBoard的优点
* 创建快, 容易上手
* 页面直观
* 页面逻辑关系清晰
* TableViewController的Static.Cell功能

### StoryBoard的缺点
* StoryBoard内容多的时候加载慢, 这个是所有程序员所不能忍受的.
* StoryBoard的segue乱, 页面少的时候还好, 一旦多起来,那个线会像蜘蛛网一样, 蜘蛛网还好, 还是有规律的, StoryBoard就是乱的不得了了
* StoryBoard的segue不灵活, 使用起来比较麻烦, 需要配置segue.identifier, 属于是硬编码, 有时候很容易配置错
* 页面间传递参数的时候麻烦, 一个方法里写跳转逻辑, 另一个方法里写参数传递, 一个控制中多个跳转的时候, 还要判断segue.identifier 这种写法我真的是受不了.
* UIStoryBoard方式创建麻烦, 创建控制器之前先创建一个UIStoryBoard对象, 然后在根据StoryBoard.identifier去创建, 标识符的配置,也是硬编码.

###  优雅的使用StoryBoard
基于以上的啰嗦, 我在想是不是可以, 像纯代码创建控制器的方式那样创建StoryBoard的VC呢, 像 CustomViewController.creatVC() 这样是不是就和原来的用法一样了, 既然想到了, 那就去实现以下吧, 正好可以用Swift来实现一下. 想要的效果

	let vc = CustomViewController.creatVC()
	vc.model = model
	navigationController?.pushViewController(vc, animated: true)

### 我的思路
* 分模块拆分StoryBoard, 这样可以减少StoryBoard的体积, 避免加载慢的问题
* segue只是做业务之间的逻辑显示, 不用它来做跳转, 或者不用它
* StoryBoard.identifier的约定, 约定所有的StoryBoard.identifier为控制器类名, 方便统一创建VC, 也不用纠结叫什么, 主要也是怕失误的时候写错, 我一般是写上类名的时候, 直接copy一下类名放到identifier上.

		let sb = UIStoryboard(name: "storyBoardName", bundle: nil)
       	let vc = sb.instantiateViewController(withIdentifier: "storyboardId") as! CustomerController
* 根据以上代码分析出需要, storyBoardName, storyboardId, 两个变量, storyboardId就是类名, 可以直接通过类名获得, 但是这个storyBoardName怎么获取呢?
* 通过属性, 好像是不行, 因为创建控制之前还没有属性, 类属性, 我也不想每个控制器都写一下, 而且也觉得不是一个好的方法, 接下来我就想到了用协议, 协议中定义一个方法, 让它返回StoryBoard name.


### 我的实现
	/// 这里可以把StoryBoard以模块划分,
	enum StoryBoardName: String {
	    case none = ""
	    case main = "Main"
	    case project = "Project"
	    case login = "Login"
	    case other = "Other"
	    case mine = "Mine"
	}
	
	protocol StoryBoardDelegate {
	    static func storyBoardName() -> StoryBoardName
	}
	
	protocol ClassNameDelete {
	    static func className() -> String
	}
	
	
	extension UIViewController: ClassNameDelete {
	    static func className() -> String {
	        if let className = classForCoder().description().components(separatedBy: ".").last {
	            return className
	        } else {
	            return classForCoder().description().components(separatedBy: ".").first!
	        }
	    }
	}
	
	
	extension BaseViewController {
    
	    /// 通用创建VC方式
	    class func creatVC() -> Self {
	        
	        let type = self.storyBoardName()
	        if type == .none {
	            return self.init()
	        } else {
	            if let vc = UIStoryboard.initVC(classType: self) {
	                return vc
	            } else {
	                debugPrint("className=\(className())创建失败")
	                return self.init()
	            }
	        }
	    }
	}

	extension UIStoryboard {
	    /// 根据类名创建 由StoryBoard 创建的控制器.
	    class func initVC<T>(classType: T.Type) -> T? where T: ClassNameDelete, T: StoryBoardDelegate {
	        let name = T.storyBoardName()
	        let sb = UIStoryboard.init(name: name.rawValue, bundle: nil)
	        let vc = sb.instantiateVC(classType: classType)
	        return vc
	    }
	    
	    func instantiateVC<T>(classType: T.Type) -> T? where T: ClassNameDelete {
	        let className = T.className()
	        let vc = instantiateViewController(withIdentifier: className)
	        return vc as? T
	    }
	}


### 具体使用
	/// 在基类中实现这个协议
	class BaseViewController: UIViewController, StoryBoardDelegate {
	
	    override func viewDidLoad() {
	        super.viewDidLoad()
	    }
		 
	    class func storyBoardName() -> StoryBoardName {
	        return .none
	    }
	} 
	
	/// 子类中实现, 若是纯代码方式创建则不需要实现这个方法.
	class TestView1Controller: BaseViewController {
	
	    override func viewDidLoad() {
	        super.viewDidLoad()
	        title = "TestView1"
	    }
	
	    override static func storyBoardName() -> StoryBoardName {
	        return .main
	    }
	    
	    @IBAction func btnToTest2Action(_ sender: UIButton) {
	        let vc = TestView2Controller.creatVC()
	        navigationController?.pushViewController(vc, animated: true)
	    }
	}


### 总结
自我感觉使用起来比较方便, 若是谁有更好的方式, 或可以优化的地方, 欢迎交流.
[代码Demo](https://github.com/mybadge/CreatVCDemo)
