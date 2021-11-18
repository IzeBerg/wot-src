package net.wg.gui.lobby.techtree.helpers
{
   import flash.display.CapsStyle;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.JointStyle;
   import flash.display.LineScaleMode;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.nodes.Renderer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class LinesGraphics extends Sprite implements IDisposable
   {
      
      protected static const UNLOCKED_LINE_THICKNESS:uint = 3;
      
      protected static const DEFAULT_LINE_THICKNESS:uint = 1;
      
      protected static const ARROW_LOCKED_ALPHA:Number = 0.2;
      
      protected static const ARROW_OPENED_ALPHA:Number = 0.5;
      
      protected static const ARROW_COLOR:uint = 16777215;
      
      private static const DEFAULT_ARROW_ALPHA:int = 1;
      
      private static const ARROW_LABEL:String = "thickness";
      
      private static const LINES_PIXEL_PERFECT_HACK_COORD:Number = 0.25;
      
      private static const MSG_UNIQUE:String = "UIID is unique value and can not be modified.";
       
      
      [Inspectable(type="Color")]
      public var unlockedLineColor:Number;
      
      [Inspectable(type="Color")]
      public var lockedLineColor:Number;
      
      public var lineThickness:int = 1;
      
      [Inspectable(defaultValue="Arrow",type="String")]
      public var arrowRenderer:String = "Arrow";
      
      protected var colorIdxs:Vector.<uint> = null;
      
      private var _container:INodesContainer = null;
      
      private var _uiid:uint = 4.294967295E9;
      
      public function LinesGraphics()
      {
         super();
      }
      
      public function clearLinesAndArrowsRenderers() : void
      {
         var _loc1_:DisplayObject = getChildByName(Renderer.LINES_AND_ARROWS_NAME);
         if(_loc1_ != null)
         {
            removeChild(_loc1_);
         }
      }
      
      public function clearUp() : void
      {
      }
      
      public function clearUpRenderer(param1:IRenderer) : void
      {
         param1.cleanUp();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function drawLine(param1:IRenderer, param2:Number, param3:Point, param4:Point, param5:int = 1, param6:Number = 1, param7:Boolean = false, param8:Boolean = false) : void
      {
         var _loc9_:Graphics = this.getLinesAndArrowsSprite(param1).graphics;
         _loc9_.lineStyle(param5,param2,param6,false,LineScaleMode.NORMAL,CapsStyle.SQUARE,JointStyle.BEVEL);
         var _loc10_:Number = this.getVectorAngle(param3,param4);
         var _loc11_:Number = param5 * Math.cos(_loc10_);
         var _loc12_:Number = param5 * Math.sin(_loc10_);
         var _loc13_:Number = 0;
         var _loc14_:Number = 0;
         if(param3.x == param4.x)
         {
            _loc14_ += param5 * (param3.y > param4.y ? -1 : 1);
         }
         else if(param3.y == param4.y)
         {
            _loc13_ += param5 * (param3.x > param4.x ? -1 : 1);
         }
         var _loc15_:Number = 0;
         if(param7)
         {
            _loc15_ = -LINES_PIXEL_PERFECT_HACK_COORD - (param5 >> 1);
         }
         if(param8)
         {
            _loc13_ -= LINES_PIXEL_PERFECT_HACK_COORD;
         }
         _loc9_.moveTo(param3.x + _loc11_ + _loc15_,param3.y + _loc12_);
         _loc9_.lineTo(param4.x - _loc11_ + _loc13_,param4.y - _loc12_ + _loc14_);
      }
      
      public function drawLineAndArrow(param1:IRenderer, param2:Number, param3:Point, param4:Point, param5:uint = 1, param6:Number = 1, param7:Boolean = false, param8:Boolean = false) : void
      {
         var _loc9_:Number = this.getVectorAngle(param3,param4);
         var _loc10_:Object = {
            "x":param4.x,
            "y":param4.y,
            "rotation":_loc9_ * 180 / Math.PI
         };
         var _loc11_:MovieClip = App.utils.classFactory.getComponent(this.arrowRenderer,MovieClip,_loc10_);
         _loc11_.gotoAndStop(ARROW_LABEL + param5);
         var _loc12_:ColorTransform = new ColorTransform();
         _loc12_.color = param2;
         _loc12_.alphaMultiplier = param6;
         _loc11_.transform.colorTransform = _loc12_;
         this.getLinesAndArrowsSprite(param1).addChild(_loc11_);
         var _loc13_:int = _loc11_.width;
         param4.x -= (_loc13_ + param5 * 0.5) * Math.cos(_loc9_);
         param4.y -= (_loc13_ + param5 * 0.5) * Math.sin(_loc9_);
         this.drawLine(param1,param2,param3,param4,param5,param6,param7,param8);
      }
      
      public function getVectorAngle(param1:Point, param2:Point) : Number
      {
         var _loc3_:Point = param2.subtract(param1);
         return Math.atan(_loc3_.y / _loc3_.x);
      }
      
      public function removeRenderer(param1:IRenderer) : void
      {
         this.clearUpRenderer(param1);
         if(contains(DisplayObject(param1)))
         {
            removeChild(DisplayObject(param1));
         }
      }
      
      public function setup() : void
      {
         this.colorIdxs = new <uint>[this.unlockedLineColor,this.lockedLineColor];
      }
      
      protected function onDispose() : void
      {
         this._container = null;
         this.colorIdxs.splice(0,this.colorIdxs.length);
         this.colorIdxs = null;
      }
      
      protected function getLinesAndArrowsSprite(param1:IRenderer, param2:Boolean = true) : Sprite
      {
         var _loc3_:String = param1.getGraphicsName();
         var _loc4_:Sprite = getChildByName(_loc3_) as Sprite;
         if(_loc4_ == null && param2)
         {
            _loc4_ = new Sprite();
            _loc4_.name = _loc3_;
            _loc4_.x = _loc4_.y = LINES_PIXEL_PERFECT_HACK_COORD;
            addChildAt(_loc4_,0);
         }
         return _loc4_;
      }
      
      protected function getLineThickness(param1:IRenderer, param2:IRenderer) : uint
      {
         if((param1.isNext2Unlock() || param1.isUnlocked()) && param2.isUnlocked())
         {
            return UNLOCKED_LINE_THICKNESS;
         }
         return DEFAULT_LINE_THICKNESS;
      }
      
      protected function getArrowAlphaByThickness(param1:int) : Number
      {
         if(param1 == UNLOCKED_LINE_THICKNESS)
         {
            return ARROW_OPENED_ALPHA;
         }
         return ARROW_LOCKED_ALPHA;
      }
      
      public function get container() : INodesContainer
      {
         return this._container;
      }
      
      public function set container(param1:INodesContainer) : void
      {
         this._container = param1;
      }
      
      [Inspectable(defaultValue="EMPTY_UIID")]
      public function get UIID() : uint
      {
         return this._uiid;
      }
      
      public function set UIID(param1:uint) : void
      {
         if(this._uiid != Values.EMPTY_UIID)
         {
            App.utils.asserter.assert(this._uiid == param1,MSG_UNIQUE);
         }
         this._uiid = param1;
      }
   }
}
