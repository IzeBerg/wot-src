package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehiclePreview.data.VPPackItemVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class PackItemsPopoverMeta extends SmartPopOverView
   {
       
      
      private var _dataProviderVPPackItemVO:DataProvider;
      
      public function PackItemsPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VPPackItemVO = null;
         if(this._dataProviderVPPackItemVO)
         {
            for each(_loc1_ in this._dataProviderVPPackItemVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderVPPackItemVO.cleanUp();
            this._dataProviderVPPackItemVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setItems(param1:String, param2:Array) : void
      {
         var _loc6_:VPPackItemVO = null;
         var _loc3_:DataProvider = this._dataProviderVPPackItemVO;
         this._dataProviderVPPackItemVO = new DataProvider();
         var _loc4_:uint = param2.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._dataProviderVPPackItemVO[_loc5_] = new VPPackItemVO(param2[_loc5_]);
            _loc5_++;
         }
         this.setItems(param1,this._dataProviderVPPackItemVO);
         if(_loc3_)
         {
            for each(_loc6_ in _loc3_)
            {
               _loc6_.dispose();
            }
            _loc3_.cleanUp();
         }
      }
      
      protected function setItems(param1:String, param2:DataProvider) : void
      {
         var _loc3_:String = "as_setItems" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
