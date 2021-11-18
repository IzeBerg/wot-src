package net.wg.gui.lobby.techtree.helpers
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
   import net.wg.gui.lobby.techtree.nodes.ResearchItem;
   
   public class ModulesGraphics extends LinesGraphics
   {
      
      private static const Y_PROP:String = "y";
       
      
      [Inspectable(type="Color")]
      public var premiumLineColor:Number;
      
      public var xRatio:int = 0;
      
      public var rootRenderer:IRenderer;
      
      public function ModulesGraphics()
      {
         super();
      }
      
      override public function clearUp() : void
      {
         super.clearUp();
         var _loc1_:int = 0;
         if(this.rootRenderer != null)
         {
            _loc1_++;
         }
         this.removeExtraRenderers(_loc1_);
      }
      
      override public function setup() : void
      {
         super.setup();
         colorIdxs = new <uint>[ARROW_COLOR,ARROW_COLOR,this.premiumLineColor];
      }
      
      override protected function onDispose() : void
      {
         this.clearUp();
         this.rootRenderer = null;
         container = null;
         super.onDispose();
      }
      
      override protected function getLineThickness(param1:IRenderer, param2:IRenderer) : uint
      {
         var _loc3_:Boolean = false;
         if((param1.isNext2Unlock() || param1.isUnlocked()) && param2.isUnlocked() && (param1 != this.rootRenderer ? Boolean(this.rootRenderer.isUnlocked()) : Boolean(true)))
         {
            if(param1 != this.rootRenderer && param2 is ResearchItem)
            {
               _loc3_ = container != null ? Boolean(IResearchContainer(container).hasUnlockedParent(param2.matrixPosition.row - 1,param2.index)) : Boolean(false);
               if(!_loc3_)
               {
                  return DEFAULT_LINE_THICKNESS;
               }
            }
            return UNLOCKED_LINE_THICKNESS;
         }
         return DEFAULT_LINE_THICKNESS;
      }
      
      public function buildRendererLines(param1:IRenderer, param2:Vector.<IRenderer>) : void
      {
         if(param2)
         {
            this.drawOutgoingLines(param1,param2);
         }
      }
      
      protected function removeExtraRenderers(param1:int) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:Number = 0;
         while(numChildren > param1)
         {
            _loc2_ = getChildAt(_loc3_);
            if(_loc2_ != this.rootRenderer)
            {
               if(_loc2_ is IRenderer)
               {
                  clearUpRenderer(IRenderer(_loc2_));
               }
               removeChildAt(_loc3_);
            }
            else
            {
               _loc3_++;
            }
         }
      }
      
      private function drawOutgoingLines(param1:IRenderer, param2:Vector.<IRenderer>) : void
      {
         var _loc17_:uint = 0;
         var _loc18_:Number = NaN;
         var _loc3_:uint = param2.length;
         if(_loc3_ == 0)
         {
            return;
         }
         var _loc4_:Point = new Point(param1.getOutX(),param1.getY());
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         var _loc7_:ResearchLineInfo = null;
         var _loc8_:ResearchLineInfo = null;
         var _loc9_:Point = null;
         var _loc10_:IRenderer = null;
         var _loc11_:Number = DEFAULT_LINE_THICKNESS;
         var _loc12_:Number = DEFAULT_LINE_THICKNESS;
         var _loc13_:uint = Math.max(param1.getColorIndex(),this.rootRenderer.getColorIndex());
         var _loc14_:Point = new Point(_loc4_.x + this.xRatio,_loc4_.y);
         var _loc15_:int = 0;
         while(_loc15_ < _loc3_)
         {
            _loc10_ = param2[_loc15_];
            if(_loc10_ != null)
            {
               _loc9_ = new Point(_loc10_.getInX(),_loc10_.getY());
               _loc8_ = new ResearchLineInfo(param1,_loc10_,_loc9_,!(_loc10_.isFake() || param1.isPremium()));
               if(_loc4_.y > _loc9_.y)
               {
                  _loc5_.push(_loc8_);
                  _loc11_ = Math.max(this.getLineThickness(_loc10_,param1),_loc11_);
               }
               else if(_loc4_.y < _loc9_.y)
               {
                  _loc6_.push(_loc8_);
                  _loc12_ = Math.max(this.getLineThickness(_loc10_,param1),_loc12_);
               }
               else
               {
                  _loc7_ = _loc8_;
               }
            }
            _loc15_++;
         }
         this.drawLines(_loc5_,_loc14_,_loc13_);
         this.drawLines(_loc6_,_loc14_,_loc13_,false);
         var _loc16_:uint = colorIdxs[_loc13_];
         if(_loc7_ != null)
         {
            _loc17_ = this.getLineThickness(_loc7_.child,_loc7_.parent);
            _loc18_ = getArrowAlphaByThickness(_loc17_);
            if(_loc7_.drawArrow)
            {
               drawLineAndArrow(param1,_loc16_,_loc4_,_loc7_.point,_loc17_,_loc18_,!param1.isFake(),true);
            }
            else
            {
               drawLine(param1,_loc16_,_loc4_,_loc7_.point,_loc17_,_loc18_,!param1.isFake());
            }
         }
         else
         {
            _loc17_ = Math.max(_loc11_,_loc12_);
            drawLine(param1,_loc16_,_loc4_,_loc14_,_loc17_,getArrowAlphaByThickness(_loc17_));
         }
      }
      
      private function drawLines(param1:Array, param2:Point, param3:uint, param4:Boolean = true) : void
      {
         var _loc6_:IRenderer = null;
         var _loc7_:IRenderer = null;
         var _loc8_:Point = null;
         var _loc9_:ResearchLineInfo = null;
         var _loc15_:Number = NaN;
         var _loc5_:uint = param1.length;
         var _loc10_:uint = DEFAULT_LINE_THICKNESS;
         var _loc11_:Number = getArrowAlphaByThickness(_loc10_);
         param1.sortOn(Y_PROP,!!param4 ? Array.NUMERIC : Array.NUMERIC | Array.DESCENDING);
         var _loc12_:Boolean = false;
         var _loc13_:int = !!param4 ? int(int.MAX_VALUE) : int(int.MIN_VALUE);
         var _loc14_:int = 0;
         var _loc16_:uint = 0;
         while(_loc16_ < _loc5_)
         {
            _loc9_ = param1[_loc16_];
            _loc7_ = _loc9_.child;
            _loc6_ = _loc9_.parent;
            _loc14_ = _loc7_.getY();
            _loc13_ = !!param4 ? int(Math.min(_loc13_,_loc14_)) : int(Math.max(_loc13_,_loc14_));
            _loc15_ = this.getLineThickness(_loc7_,_loc6_);
            _loc11_ = getArrowAlphaByThickness(_loc15_);
            if(_loc12_)
            {
               if(_loc10_ < _loc15_)
               {
                  _loc12_ = true;
                  drawLine(_loc6_,colorIdxs[param3],param2,new Point(param2.x,_loc14_),_loc15_,_loc11_);
                  drawLine(_loc6_,colorIdxs[param3],new Point(param2.x,_loc14_),new Point(param2.x,_loc13_),_loc10_,getArrowAlphaByThickness(_loc10_));
               }
               _loc10_ = _loc15_;
            }
            _loc8_ = new Point(param2.x,_loc9_.point.y);
            if(_loc9_.drawArrow)
            {
               drawLineAndArrow(_loc6_,colorIdxs[param3],_loc8_,_loc9_.point,_loc15_,_loc11_,false,true);
            }
            else
            {
               drawLine(_loc6_,colorIdxs[param3],_loc8_,_loc9_.point,_loc15_,_loc11_);
            }
            if(!_loc12_ && _loc16_ == _loc5_ - 1)
            {
               drawLine(_loc6_,colorIdxs[param3],param2,new Point(param2.x,_loc13_),_loc15_,_loc11_);
            }
            _loc16_++;
         }
      }
   }
}

import flash.geom.Point;
import net.wg.gui.lobby.techtree.interfaces.IRenderer;

class ResearchLineInfo
{
    
   
   public var point:Point;
   
   public var parent:IRenderer;
   
   public var child:IRenderer;
   
   public var drawArrow:Boolean;
   
   function ResearchLineInfo(param1:IRenderer, param2:IRenderer, param3:Point, param4:Boolean)
   {
      super();
      this.parent = param1;
      this.child = param2;
      this.point = param3;
      this.drawArrow = param4;
   }
   
   public function get y() : Number
   {
      return this.point.y;
   }
}
