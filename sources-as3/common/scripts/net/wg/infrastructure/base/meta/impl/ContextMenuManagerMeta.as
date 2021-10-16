package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.ContextMenuOptionsVO;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ContextMenuManagerMeta extends BaseDAAPIModule
   {
       
      
      public var requestOptions:Function;
      
      public var onOptionSelect:Function;
      
      public var onHide:Function;
      
      private var _contextMenuOptionsVO:ContextMenuOptionsVO;
      
      public function ContextMenuManagerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._contextMenuOptionsVO)
         {
            this._contextMenuOptionsVO.dispose();
            this._contextMenuOptionsVO = null;
         }
         super.onDispose();
      }
      
      public function requestOptionsS(param1:String, param2:Object = null) : void
      {
         App.utils.asserter.assertNotNull(this.requestOptions,"requestOptions" + Errors.CANT_NULL);
         this.requestOptions(param1,param2);
      }
      
      public function onOptionSelectS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onOptionSelect,"onOptionSelect" + Errors.CANT_NULL);
         this.onOptionSelect(param1);
      }
      
      public function onHideS() : void
      {
         App.utils.asserter.assertNotNull(this.onHide,"onHide" + Errors.CANT_NULL);
         this.onHide();
      }
      
      public final function as_setOptions(param1:Object) : void
      {
         var _loc2_:ContextMenuOptionsVO = this._contextMenuOptionsVO;
         this._contextMenuOptionsVO = new ContextMenuOptionsVO(param1);
         this.setOptions(this._contextMenuOptionsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setOptions(param1:ContextMenuOptionsVO) : void
      {
         var _loc2_:String = "as_setOptions" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
