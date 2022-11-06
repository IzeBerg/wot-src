package net.wg.gui.lobby.hangar
{
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.lobby.components.data.VehParamVO;
   import net.wg.gui.lobby.hangar.vehicleParameters.components.VehParamRendererWithHighlight;
   import net.wg.infrastructure.base.meta.IVehicleParametersWithHighlightMeta;
   import net.wg.infrastructure.base.meta.impl.VehicleParametersWithHighlightMeta;
   
   public class VehicleParametersWithHighlight extends VehicleParametersWithHighlightMeta implements IVehicleParametersWithHighlightMeta
   {
      
      private static const INV_GLOW_ANIM:String = "invGlowAnim";
      
      private static const highlightTypes:Vector.<String> = new <String>[HANGAR_ALIASES.VEH_PARAM_RENDERER_HIGHLIGHT_POSITIVE,HANGAR_ALIASES.VEH_PARAM_RENDERER_HIGHLIGHT_MIXED,HANGAR_ALIASES.VEH_PARAM_RENDERER_HIGHLIGHT_NEGATIVE];
       
      
      public function VehicleParametersWithHighlight()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:VehParamRendererWithHighlight = null;
         super.draw();
         if(isInvalid(INV_GLOW_ANIM))
         {
            _loc1_ = paramsList.renderersCount;
            _loc2_ = 0;
            while(_loc2_ != _loc1_)
            {
               _loc3_ = VehParamRendererWithHighlight(paramsList.getRendererAt(_loc2_));
               if(_loc3_)
               {
                  _loc3_.playHighlightAnimation();
               }
               _loc2_++;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.scrollToHighlightedItem);
         super.onDispose();
      }
      
      override protected function getRendererLinkage() : String
      {
         return Linkages.VEH_PARAMS_RENDERER_WITH_HIGHLIGHT_UI;
      }
      
      public function as_showChanges() : void
      {
         App.utils.scheduler.cancelTask(this.scrollToHighlightedItem);
         App.utils.scheduler.scheduleOnNextFrame(this.scrollToHighlightedItem);
      }
      
      private function searchForItem(param1:String) : int
      {
         var _loc5_:VehParamVO = null;
         var _loc2_:int = _dataProvider.length;
         var _loc3_:int = Values.DEFAULT_INT;
         var _loc4_:int = 0;
         while(_loc4_ != _loc2_)
         {
            _loc5_ = this.getItemByIndex(_loc4_);
            if(_loc5_.highlight == param1)
            {
               _loc3_ = _loc4_;
               break;
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function getItemByIndex(param1:int) : VehParamVO
      {
         if(param1 != Values.DEFAULT_INT)
         {
            return VehParamVO(_dataProvider.requestItemAt(param1));
         }
         return null;
      }
      
      private function scrollToHighlightedItem() : void
      {
         var _loc3_:String = null;
         var _loc6_:int = 0;
         var _loc7_:VehParamVO = null;
         var _loc8_:int = 0;
         var _loc1_:int = Values.DEFAULT_INT;
         var _loc2_:VehParamVO = null;
         for each(_loc3_ in highlightTypes)
         {
            _loc1_ = this.searchForItem(_loc3_);
            _loc2_ = this.getItemByIndex(_loc1_);
            if(_loc2_)
            {
               break;
            }
         }
         if(!_loc2_)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc5_:String = _loc2_.parentID;
         if(_loc1_ < paramsList.scrollPosition)
         {
            _loc6_ = _loc1_;
            while(_loc6_ > 0)
            {
               _loc7_ = this.getItemByIndex(_loc6_);
               if(_loc7_.paramID == _loc5_)
               {
                  _loc4_ = _loc6_ - 1;
                  break;
               }
               _loc6_--;
            }
         }
         else
         {
            _loc8_ = _dataProvider.length;
            _loc4_ = _loc8_ - 1;
            _loc6_ = _loc1_;
            while(_loc6_ != _loc8_)
            {
               _loc7_ = this.getItemByIndex(_loc6_);
               if(_loc5_ != _loc7_.parentID)
               {
                  _loc4_ = _loc6_ - 1;
                  break;
               }
               _loc6_++;
            }
         }
         if(_loc4_ != Values.DEFAULT_INT)
         {
            paramsList.scrollToIndex(_loc4_);
         }
         invalidate(INV_GLOW_ANIM);
      }
   }
}
