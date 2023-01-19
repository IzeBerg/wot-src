package net.wg.mock
{
   import flash.accessibility.AccessibilityProperties;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Scene;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Transform;
   import flash.media.SoundTransform;
   import net.wg.data.daapi.LoadViewVO;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.managers.IWaitingView;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.InputEvent;
   
   public class MockWaitingView implements IWaitingView
   {
       
      
      public function MockWaitingView()
      {
         super();
      }
      
      public function addChild(param1:DisplayObject) : DisplayObject
      {
         return null;
      }
      
      public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         return null;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function areInaccessibleObjectsUnderPoint(param1:Point) : Boolean
      {
         return false;
      }
      
      public function as_dispose() : void
      {
      }
      
      public function as_hideWaiting() : void
      {
      }
      
      public function as_isDAAPIInited() : Boolean
      {
         return false;
      }
      
      public function as_populate() : void
      {
      }
      
      public function as_showAwards(param1:Boolean) : void
      {
      }
      
      public function as_showWaiting(param1:String, param2:Boolean) : void
      {
      }
      
      public function contains(param1:DisplayObject) : Boolean
      {
         return false;
      }
      
      public final function dispose() : void
      {
      }
      
      public function getBounds(param1:DisplayObject) : Rectangle
      {
         return null;
      }
      
      public function getChildAt(param1:int) : DisplayObject
      {
         return null;
      }
      
      public function getChildByName(param1:String) : DisplayObject
      {
         return null;
      }
      
      public function getChildIndex(param1:DisplayObject) : int
      {
         return 0;
      }
      
      public function getObjectsUnderPoint(param1:Point) : Array
      {
         return null;
      }
      
      public function getRect(param1:DisplayObject) : Rectangle
      {
         return null;
      }
      
      public function getSubContainers() : Array
      {
         return null;
      }
      
      public function globalToLocal(param1:Point) : Point
      {
         return null;
      }
      
      public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
      }
      
      public function gotoAndStop(param1:Object, param2:String = null) : void
      {
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function hitTestObject(param1:DisplayObject) : Boolean
      {
         return false;
      }
      
      public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean
      {
         return false;
      }
      
      public function invalidate(... rest) : void
      {
      }
      
      public function leaveModalFocus() : void
      {
      }
      
      public function localToGlobal(param1:Point) : Point
      {
         return null;
      }
      
      public function nextFrame() : void
      {
      }
      
      public function nextScene() : void
      {
      }
      
      public function play() : void
      {
      }
      
      public function playHideTween(param1:DisplayObject, param2:Function = null) : Boolean
      {
         return false;
      }
      
      public function playShowTween(param1:DisplayObject, param2:Function = null) : Boolean
      {
         return false;
      }
      
      public function prevFrame() : void
      {
      }
      
      public function prevScene() : void
      {
      }
      
      public function removeChild(param1:DisplayObject) : DisplayObject
      {
         return null;
      }
      
      public function removeChildAt(param1:int) : DisplayObject
      {
         return null;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function setActualScale(param1:Number, param2:Number) : void
      {
      }
      
      [Inspectable(defaultValue="false")]
      public function setActualSize(param1:Number, param2:Number) : void
      {
      }
      
      public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
      }
      
      public function setModalFocus() : void
      {
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
      }
      
      public function startDrag(param1:Boolean = false, param2:Rectangle = null) : void
      {
      }
      
      public function stop() : void
      {
      }
      
      public function stopDrag() : void
      {
      }
      
      public function swapChildren(param1:DisplayObject, param2:DisplayObject) : void
      {
      }
      
      public function swapChildrenAt(param1:int, param2:int) : void
      {
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return false;
      }
      
      public function get currentFrame() : int
      {
         return 0;
      }
      
      public function get framesLoaded() : int
      {
         return 0;
      }
      
      public function get totalFrames() : int
      {
         return 0;
      }
      
      public function get trackAsMenu() : Boolean
      {
         return false;
      }
      
      public function set trackAsMenu(param1:Boolean) : void
      {
      }
      
      public function get scenes() : Array
      {
         return null;
      }
      
      public function get currentScene() : Scene
      {
         return null;
      }
      
      public function get currentFrameLabel() : String
      {
         return "";
      }
      
      public function get currentLabels() : Array
      {
         return null;
      }
      
      public function get graphics() : Graphics
      {
         return null;
      }
      
      public function get buttonMode() : Boolean
      {
         return false;
      }
      
      public function set buttonMode(param1:Boolean) : void
      {
      }
      
      public function get dropTarget() : DisplayObject
      {
         return null;
      }
      
      public function get hitArea() : Sprite
      {
         return null;
      }
      
      public function set hitArea(param1:Sprite) : void
      {
      }
      
      public function get useHandCursor() : Boolean
      {
         return false;
      }
      
      public function set useHandCursor(param1:Boolean) : void
      {
      }
      
      public function get soundTransform() : SoundTransform
      {
         return null;
      }
      
      public function set soundTransform(param1:SoundTransform) : void
      {
      }
      
      public function get numChildren() : int
      {
         return 0;
      }
      
      public function get tabChildren() : Boolean
      {
         return false;
      }
      
      public function set tabChildren(param1:Boolean) : void
      {
      }
      
      public function get tabIndex() : int
      {
         return 0;
      }
      
      public function set tabIndex(param1:int) : void
      {
      }
      
      public function get focusRect() : Object
      {
         return null;
      }
      
      public function set focusRect(param1:Object) : void
      {
      }
      
      public function get root() : DisplayObject
      {
         return null;
      }
      
      public function get stage() : Stage
      {
         return null;
      }
      
      public function get parent() : DisplayObjectContainer
      {
         return null;
      }
      
      public function get mask() : DisplayObject
      {
         return null;
      }
      
      public function set mask(param1:DisplayObject) : void
      {
      }
      
      public function get mouseX() : Number
      {
         return 0;
      }
      
      public function get mouseY() : Number
      {
         return 0;
      }
      
      public function get rotation() : Number
      {
         return 0;
      }
      
      public function set rotation(param1:Number) : void
      {
      }
      
      public function get cacheAsBitmap() : Boolean
      {
         return false;
      }
      
      public function set cacheAsBitmap(param1:Boolean) : void
      {
      }
      
      public function get opaqueBackground() : Object
      {
         return null;
      }
      
      public function set opaqueBackground(param1:Object) : void
      {
      }
      
      public function get scrollRect() : Rectangle
      {
         return null;
      }
      
      public function set scrollRect(param1:Rectangle) : void
      {
      }
      
      public function get filters() : Array
      {
         return null;
      }
      
      public function set filters(param1:Array) : void
      {
      }
      
      public function get blendMode() : String
      {
         return "";
      }
      
      public function set blendMode(param1:String) : void
      {
      }
      
      public function get loaderInfo() : LoaderInfo
      {
         return null;
      }
      
      public function get accessibilityProperties() : AccessibilityProperties
      {
         return null;
      }
      
      public function set accessibilityProperties(param1:AccessibilityProperties) : void
      {
      }
      
      public function get isOnStage() : Boolean
      {
         return false;
      }
      
      public function get isFocusable() : Boolean
      {
         return true;
      }
      
      public function get scaleX() : Number
      {
         return 0;
      }
      
      public function set scaleX(param1:Number) : void
      {
      }
      
      public function get scaleY() : Number
      {
         return 0;
      }
      
      public function set scaleY(param1:Number) : void
      {
      }
      
      public function get enableInitCallback() : Boolean
      {
         return false;
      }
      
      public function set enableInitCallback(param1:Boolean) : void
      {
      }
      
      public function get name() : String
      {
         return "";
      }
      
      public function set name(param1:String) : void
      {
      }
      
      public function get mouseEnabled() : Boolean
      {
         return false;
      }
      
      public function set mouseEnabled(param1:Boolean) : void
      {
      }
      
      public function get mouseChildren() : Boolean
      {
         return false;
      }
      
      public function set mouseChildren(param1:Boolean) : void
      {
      }
      
      public function get actualWidth() : Number
      {
         return 0;
      }
      
      public function get actualHeight() : Number
      {
         return 0;
      }
      
      public function get actualScaleX() : Number
      {
         return 0;
      }
      
      public function get actualScaleY() : Number
      {
         return 0;
      }
      
      public function get transform() : Transform
      {
         return null;
      }
      
      public function set transform(param1:Transform) : void
      {
      }
      
      public function get x() : Number
      {
         return 0;
      }
      
      public function set x(param1:Number) : void
      {
      }
      
      public function get y() : Number
      {
         return 0;
      }
      
      public function set y(param1:Number) : void
      {
      }
      
      public function get width() : Number
      {
         return 0;
      }
      
      public function set width(param1:Number) : void
      {
      }
      
      public function get height() : Number
      {
         return 0;
      }
      
      public function set height(param1:Number) : void
      {
      }
      
      public function get enabled() : Boolean
      {
         return false;
      }
      
      public function set enabled(param1:Boolean) : void
      {
      }
      
      public function get tabEnabled() : Boolean
      {
         return false;
      }
      
      public function set tabEnabled(param1:Boolean) : void
      {
      }
      
      public function get scale9Grid() : Rectangle
      {
         return null;
      }
      
      public function set scale9Grid(param1:Rectangle) : void
      {
      }
      
      public function get alpha() : Number
      {
         return 0;
      }
      
      public function set alpha(param1:Number) : void
      {
      }
      
      public function get doubleClickEnabled() : Boolean
      {
         return false;
      }
      
      public function set doubleClickEnabled(param1:Boolean) : void
      {
      }
      
      public function get focusTarget() : UIComponent
      {
         return null;
      }
      
      public function set focusTarget(param1:UIComponent) : void
      {
      }
      
      public function get UIID() : uint
      {
         return 0;
      }
      
      public function set UIID(param1:uint) : void
      {
      }
      
      public function get visible() : Boolean
      {
         return false;
      }
      
      public function set visible(param1:Boolean) : void
      {
      }
      
      public function get as_config() : LoadViewVO
      {
         return null;
      }
      
      public function set as_config(param1:LoadViewVO) : void
      {
      }
      
      public function get loader() : Loader
      {
         return null;
      }
      
      public function set loader(param1:Loader) : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return false;
      }
      
      public function get isModal() : Boolean
      {
         return false;
      }
      
      public function get modalAlpha() : Number
      {
         return 0;
      }
      
      public function get sourceView() : IView
      {
         return null;
      }
      
      public function get containerContent() : IManagedContent
      {
         return null;
      }
      
      public function get viewTutorialId() : String
      {
         return "";
      }
      
      public function set viewTutorialId(param1:String) : void
      {
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
      
      public function validateNow(param1:Event = null) : void
      {
      }
      
      public function handleInput(param1:InputEvent) : void
      {
      }
      
      public function as_showBackgroundImg(param1:String) : void
      {
      }
      
      public function isDisposed() : Boolean
      {
         return false;
      }
   }
}
