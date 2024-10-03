package net.wg.gui.lobby.techtree.helpers
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.techtree.controls.NodeLock;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
   import net.wg.gui.lobby.techtree.nodes.FakeNode;
   import net.wg.gui.lobby.techtree.nodes.ResearchItem;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class ModulesGraphics extends LinesGraphics
   {
      
      protected static const LOCKED_LINE_COMP_NAME:String = "ResearchLineLocked";
      
      protected static const LOCKED_TWO_LINES_COMP_NAME:String = "ResearchTwoLinesLocked";
      
      protected static const LOCKED_THREE_LINES_COMP_NAME:String = "ResearchThreeLinesLocked";
      
      protected static const EARLY_ACCESS_LOCKED_LINE_COMP_NAME:String = "EarlyAccessResearchLineLocked";
      
      private static const Y_PROP:String = "y";
       
      
      [Inspectable(type="Color")]
      public var premiumLineColor:Number;
      
      public var xRatio:int = 0;
      
      public var rootRenderer:IRenderer;
      
      private var _lineAndArrowLocks:Vector.<NodeLock> = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function ModulesGraphics()
      {
         this._toolTipMgr = App.toolTipMgr;
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
         this.clearLineAndArrowLocks();
         this.clearUp();
         this._toolTipMgr = null;
         this.rootRenderer = null;
         container = null;
         super.onDispose();
      }
      
      override public function clearLinesAndArrowsRenderers() : void
      {
         super.clearLinesAndArrowsRenderers();
         this.clearLineAndArrowLocks();
      }
      
      override protected function getLineThickness(param1:IRenderer, param2:IRenderer) : uint
      {
         var _loc3_:Boolean = false;
         if(param2.isUnlocked() && (param1.isNext2Unlock() || param1.isUnlocked()) && (param1 != this.rootRenderer ? Boolean(this.rootRenderer.isUnlocked()) : Boolean(true)))
         {
            if(param1 != this.rootRenderer && param2 is ResearchItem)
            {
               _loc3_ = container != null ? Boolean(IResearchContainer(container).hasUnlockedParent(param2.matrixPosition.row - 1,param2.index)) : Boolean(false);
               if(!_loc3_)
               {
                  return DEFAULT_LINE_THICKNESS;
               }
            }
            if(param1.getNodeData() && param1.getNodeData().isEarlyAccess)
            {
               return DEFAULT_LINE_THICKNESS;
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
         var _loc3_:int = 0;
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
      
      protected function createLineAndArrowLock(param1:String, param2:IRenderer, param3:Object = null) : NodeLock
      {
         if(this._lineAndArrowLocks == null)
         {
            this._lineAndArrowLocks = new Vector.<NodeLock>(0);
         }
         var _loc4_:NodeLock = App.utils.classFactory.getComponent(param1,NodeLock,param3);
         _loc4_.renderer = param2;
         _loc4_.addEventListener(MouseEvent.ROLL_OVER,this.onLockedOverlayRollOverHandler,false,0,true);
         _loc4_.addEventListener(MouseEvent.ROLL_OUT,this.onLockedOverlayRollOutHandler,false,0,true);
         this._lineAndArrowLocks.push(_loc4_);
         return _loc4_;
      }
      
      protected function clearLineAndArrowLocks() : void
      {
         var _loc1_:NodeLock = null;
         if(this._lineAndArrowLocks != null)
         {
            for each(_loc1_ in this._lineAndArrowLocks)
            {
               _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onLockedOverlayRollOverHandler);
               _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onLockedOverlayRollOutHandler);
               _loc1_.dispose();
            }
            this._lineAndArrowLocks.length = 0;
            this._lineAndArrowLocks = null;
         }
      }
      
      private function drawOutgoingLines(param1:IRenderer, param2:Vector.<IRenderer>) : void
      {
         var _loc17_:uint = 0;
         var _loc18_:Number = NaN;
         var _loc19_:IRenderer = null;
         var _loc20_:uint = 0;
         var _loc21_:FakeNode = null;
         var _loc22_:IRenderer = null;
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
            _loc19_ = _loc7_.child;
            _loc17_ = this.getLineThickness(_loc19_,_loc7_.parent);
            _loc18_ = getArrowAlphaByThickness(_loc17_);
            if(_loc7_.drawArrow)
            {
               drawLineAndArrow(param1,_loc16_,_loc4_,_loc7_.point,_loc17_,_loc18_,!param1.isFake(),true,getLineStyle(_loc19_));
            }
            else
            {
               _loc20_ = getLineStyle(_loc19_);
               if(_loc19_.isFake())
               {
                  _loc21_ = _loc19_ as FakeNode;
                  if(_loc21_ != null)
                  {
                     _loc22_ = _loc21_.getFirstChild();
                     if(_loc22_ != null)
                     {
                        _loc20_ = getLineStyle(_loc22_);
                     }
                  }
               }
               drawLine(param1,_loc16_,_loc4_,_loc7_.point,_loc17_,_loc18_,!param1.isFake(),false,_loc20_);
            }
         }
         else
         {
            _loc17_ = Math.max(_loc11_,_loc12_);
            drawLine(param1,_loc16_,_loc4_,_loc14_,_loc17_,getArrowAlphaByThickness(_loc17_));
         }
      }
      
      private function onLockedOverlayRollOverHandler(param1:MouseEvent) : void
      {
         var _loc3_:NodeData = null;
         var _loc2_:NodeLock = param1.target as NodeLock;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.renderer.getNodeData();
            if(_loc3_)
            {
               this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECHTREE_VEHICLE_STATUS,null,_loc3_,this.rootRenderer.getID());
            }
         }
      }
      
      private function onLockedOverlayRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
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
