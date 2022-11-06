package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.eventHangar.data.EventShopEntryPointVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventShopEntryPointMeta extends BaseDAAPIComponent
   {
       
      
      public var onClick:Function;
      
      private var _eventShopEntryPointVO:EventShopEntryPointVO;
      
      public function EventShopEntryPointMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._eventShopEntryPointVO)
         {
            this._eventShopEntryPointVO.dispose();
            this._eventShopEntryPointVO = null;
         }
         super.onDispose();
      }
      
      public function onClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onClick,"onClick" + Errors.CANT_NULL);
         this.onClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EventShopEntryPointVO = this._eventShopEntryPointVO;
         this._eventShopEntryPointVO = new EventShopEntryPointVO(param1);
         this.setData(this._eventShopEntryPointVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EventShopEntryPointVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
