package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.advanced.vo.DummyVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseStorageCategoryViewMeta extends BaseDAAPIComponent
   {
       
      
      public var setActiveState:Function;
      
      public var playInfoSound:Function;
      
      public var scrolledToBottom:Function;
      
      private var _dummyVO:DummyVO;
      
      public function BaseStorageCategoryViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dummyVO)
         {
            this._dummyVO.dispose();
            this._dummyVO = null;
         }
         super.onDispose();
      }
      
      public function setActiveStateS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setActiveState,"setActiveState" + Errors.CANT_NULL);
         this.setActiveState(param1);
      }
      
      public function playInfoSoundS() : void
      {
         App.utils.asserter.assertNotNull(this.playInfoSound,"playInfoSound" + Errors.CANT_NULL);
         this.playInfoSound();
      }
      
      public function scrolledToBottomS() : void
      {
         App.utils.asserter.assertNotNull(this.scrolledToBottom,"scrolledToBottom" + Errors.CANT_NULL);
         this.scrolledToBottom();
      }
      
      public final function as_showFilterWarning(param1:Object) : void
      {
         var _loc2_:DummyVO = this._dummyVO;
         this._dummyVO = new DummyVO(param1);
         this.showFilterWarning(this._dummyVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function showFilterWarning(param1:DummyVO) : void
      {
         var _loc2_:String = "as_showFilterWarning" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
