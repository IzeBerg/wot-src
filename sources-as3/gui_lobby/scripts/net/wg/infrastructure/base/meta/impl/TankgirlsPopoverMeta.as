package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.TankgirlVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.data.DataProvider;
   
   public class TankgirlsPopoverMeta extends SmartPopOverView
   {
       
      
      public var onRecruitClick:Function;
      
      private var _dataProviderTankgirlVO:DataProvider;
      
      public function TankgirlsPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TankgirlVO = null;
         if(this._dataProviderTankgirlVO)
         {
            for each(_loc1_ in this._dataProviderTankgirlVO)
            {
               _loc1_.dispose();
            }
            this._dataProviderTankgirlVO.cleanUp();
            this._dataProviderTankgirlVO = null;
         }
         super.onDispose();
      }
      
      public function onRecruitClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onRecruitClick,"onRecruitClick" + Errors.CANT_NULL);
         this.onRecruitClick(param1);
      }
      
      public final function as_setListDataProvider(param1:Array) : void
      {
         var _loc5_:TankgirlVO = null;
         var _loc2_:DataProvider = this._dataProviderTankgirlVO;
         this._dataProviderTankgirlVO = new DataProvider();
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._dataProviderTankgirlVO[_loc4_] = new TankgirlVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setListDataProvider(this._dataProviderTankgirlVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.cleanUp();
         }
      }
      
      protected function setListDataProvider(param1:DataProvider) : void
      {
         var _loc2_:String = "as_setListDataProvider" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
