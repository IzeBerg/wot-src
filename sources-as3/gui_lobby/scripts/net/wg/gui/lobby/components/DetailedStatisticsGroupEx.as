package net.wg.gui.lobby.components
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.containers.GroupEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class DetailedStatisticsGroupEx extends GroupEx
   {
      
      private static const UNIT_RENDERER_INVALID:String = "unitRendInv";
       
      
      private var _unitRendererLinkage:String;
      
      public function DetailedStatisticsGroupEx()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         itemRendererLinkage = Linkages.DETAILED_STATISTICS_UNIT;
      }
      
      override protected function commitProperties() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.commitProperties();
         if(isInvalid(UNIT_RENDERER_INVALID,InvalidationType.DATA))
         {
            _loc1_ = numRenderers();
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this.adjustUnitAt(_loc2_);
               _loc2_++;
            }
            invalidateLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         this._unitRendererLinkage = null;
         super.onDispose();
      }
      
      protected function adjustUnitAt(param1:int) : DetailedStatisticsUnit
      {
         var _loc2_:DetailedStatisticsUnit = DetailedStatisticsUnit(getRendererAt(param1));
         _loc2_.itemRendererLinkage = this._unitRendererLinkage;
         return _loc2_;
      }
      
      public function get unitRendererLinkage() : String
      {
         return this._unitRendererLinkage;
      }
      
      public function set unitRendererLinkage(param1:String) : void
      {
         if(this._unitRendererLinkage != param1)
         {
            this._unitRendererLinkage = param1;
            invalidate(UNIT_RENDERER_INVALID,InvalidationType.LAYOUT);
         }
      }
   }
}
