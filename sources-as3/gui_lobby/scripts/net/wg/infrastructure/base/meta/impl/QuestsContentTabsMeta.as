package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.data.TabsVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class QuestsContentTabsMeta extends BaseDAAPIComponent
   {
       
      
      public var onSelectTab:Function;
      
      private var _tabsVO:TabsVO;
      
      public function QuestsContentTabsMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._tabsVO)
         {
            this._tabsVO.dispose();
            this._tabsVO = null;
         }
         super.onDispose();
      }
      
      public function onSelectTabS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectTab,"onSelectTab" + Errors.CANT_NULL);
         this.onSelectTab(param1);
      }
      
      public final function as_setTabs(param1:Object) : void
      {
         var _loc2_:TabsVO = this._tabsVO;
         this._tabsVO = new TabsVO(param1);
         this.setTabs(this._tabsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setTabs(param1:TabsVO) : void
      {
         var _loc2_:String = "as_setTabs" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
