package net.wg.gui.lobby.techtree.helpers
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.techtree.constants.ColorIndex;
   import net.wg.gui.lobby.techtree.constants.LineStyle;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ResearchGraphics extends ModulesGraphics
   {
      
      private static const FADE_OUT_ARROW_LOCKED:String = "ResearchArrowDisFadeOutUI";
      
      private static const FADE_OUT_ARROW:String = "ResearchArrowFadeOutUI";
      
      private static const FADE_IN_ARROW_LOCKED:String = "ResearchArrowDisFadeInUI";
      
      private static const FADE_IN_ARROW:String = "ResearchArrowFadeInUI";
      
      private static const DASHED_ARROW_ASSET_PREFIX:String = "Dashed";
      
      private static const MAX_LEVEL:uint = 10;
      
      private static const MIN_LEVEL:uint = 1;
       
      
      public function ResearchGraphics()
      {
         super();
      }
      
      private static function onLockedOverlayRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override public function buildRendererLines(param1:IRenderer, param2:Vector.<IRenderer>) : void
      {
         var _loc4_:Vector.<IRenderer> = null;
         var _loc5_:uint = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Sprite = null;
         super.buildRendererLines(param1,param2);
         var _loc3_:Object = null;
         if(param1 == rootRenderer)
         {
            _loc4_ = IResearchContainer(container).getTopLevel();
            _loc5_ = _loc4_.length;
            if(_loc5_ > 1)
            {
               this.drawIngoingLine(_loc4_);
            }
            _loc6_ = Values.EMPTY_STR;
            if(param1.getNodeData().isEarlyAccess && (param1.getNodeData().isEarlyAccessLocked || param1.isLocked()))
            {
               _loc6_ = EARLY_ACCESS_LOCKED_LINE_COMP_NAME;
            }
            else if(param1.isLocked() && _loc5_ > 0)
            {
               _loc6_ = LOCKED_THREE_LINES_COMP_NAME;
               switch(_loc5_)
               {
                  case 1:
                     _loc6_ = LOCKED_LINE_COMP_NAME;
                     break;
                  case 2:
                     _loc6_ = LOCKED_TWO_LINES_COMP_NAME;
               }
            }
            if(StringUtils.isNotEmpty(_loc6_))
            {
               _loc3_ = {
                  "x":param1.getInX(),
                  "y":param1.getY()
               };
               getLinesAndArrowsSprite(param1).addChild(createLineAndArrowLock(_loc6_,param1,_loc3_));
            }
         }
         else if(NodeEntityType.isVehicleType(param1.entityType) && param1.getLevel() < MAX_LEVEL)
         {
            _loc3_ = {
               "x":param1.getOutX(),
               "y":param1.getY()
            };
            _loc7_ = !!param1.isUnlocked() ? FADE_OUT_ARROW : FADE_OUT_ARROW_LOCKED;
            if(getLineStyle(param1) == LineStyle.DASHED)
            {
               _loc7_ = DASHED_ARROW_ASSET_PREFIX + _loc7_;
            }
            _loc8_ = App.utils.classFactory.getComponent(_loc7_,Sprite,_loc3_);
            _loc8_.y -= _loc8_.height >> 1;
            getLinesAndArrowsSprite(param1).addChild(_loc8_);
         }
      }
      
      public function buildTopRenderersLines(param1:Vector.<IRenderer>) : void
      {
         var _loc2_:IRenderer = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc5_:Sprite = null;
         if(param1 && param1.length)
         {
            for each(_loc2_ in param1)
            {
               this.drawTopRendererLine(_loc2_,param1.length == 1);
               if(NodeEntityType.isVehicleType(_loc2_.entityType) && _loc2_.getLevel() > MIN_LEVEL)
               {
                  _loc3_ = {
                     "x":_loc2_.getInX(),
                     "y":_loc2_.getY()
                  };
                  _loc4_ = !!_loc2_.isLocked() ? FADE_IN_ARROW_LOCKED : FADE_IN_ARROW;
                  if(getLineStyle(_loc2_) == LineStyle.DASHED)
                  {
                     _loc4_ = DASHED_ARROW_ASSET_PREFIX + _loc4_;
                  }
                  _loc5_ = App.utils.classFactory.getComponent(_loc4_,Sprite,_loc3_);
                  _loc5_.y -= _loc5_.height >> 1;
                  getLinesAndArrowsSprite(_loc2_).addChild(_loc5_);
               }
            }
         }
      }
      
      private function drawIngoingLine(param1:Vector.<IRenderer>) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc2_:Point = new Point(rootRenderer.getInX(),rootRenderer.getY());
         var _loc3_:Point = new Point(param1[0].getOutX() + xRatio,_loc2_.y);
         if(rootRenderer.isNext2Unlock() || rootRenderer.isUnlocked())
         {
            _loc4_ = ColorIndex.UNLOCKED;
            _loc5_ = UNLOCKED_LINE_THICKNESS;
         }
         else
         {
            _loc4_ = rootRenderer.getColorIndex();
            _loc5_ = DEFAULT_LINE_THICKNESS;
         }
         var _loc6_:Number = getArrowAlphaByThickness(_loc5_);
         if(!rootRenderer.isPremium())
         {
            drawLineAndArrow(rootRenderer,colorIdxs[_loc4_],_loc3_,_loc2_,_loc5_,_loc6_,false,true,getLineStyle(rootRenderer));
         }
         else
         {
            drawLine(rootRenderer,colorIdxs[_loc4_],_loc3_,_loc2_,_loc5_,_loc6_);
         }
      }
      
      private function drawTopRendererLine(param1:IRenderer, param2:Boolean = false) : void
      {
         var _loc6_:Point = null;
         var _loc3_:Point = new Point(param1.getOutX(),param1.getY());
         var _loc4_:Point = new Point(rootRenderer.getInX(),rootRenderer.getY());
         var _loc5_:uint = rootRenderer.getColorIndex(param1);
         var _loc7_:int = getLineThickness(rootRenderer,param1);
         var _loc8_:Number = getArrowAlphaByThickness(_loc7_);
         if(_loc3_.y == _loc4_.y)
         {
            if(param2)
            {
               drawLineAndArrow(param1,colorIdxs[_loc5_],_loc3_,_loc4_,_loc7_,_loc8_,false,true,getLineStyle(rootRenderer));
            }
            else
            {
               _loc4_.x = _loc3_.x + xRatio;
               drawLine(param1,colorIdxs[_loc5_],_loc3_,_loc4_,_loc7_,_loc8_);
            }
         }
         else
         {
            _loc6_ = new Point(_loc3_.x + xRatio,_loc3_.y);
            drawLine(param1,colorIdxs[_loc5_],_loc3_,_loc6_,_loc7_,_loc8_);
            _loc3_ = _loc6_;
            _loc6_ = new Point(_loc3_.x,_loc4_.y);
            drawLine(param1,colorIdxs[_loc5_],_loc3_,_loc6_,_loc7_,_loc8_);
            if(param2)
            {
               drawLineAndArrow(param1,colorIdxs[_loc5_],_loc6_,_loc4_,_loc7_,_loc8_,false,true,getLineStyle(rootRenderer));
            }
         }
      }
      
      private function onLockedOverlayRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:NodeData = null;
         if(rootRenderer)
         {
            _loc2_ = rootRenderer.getNodeData();
            if(_loc2_)
            {
               App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECHTREE_VEHICLE_STATUS,null,_loc2_,rootRenderer.getID());
            }
         }
      }
   }
}
