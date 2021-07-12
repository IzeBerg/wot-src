package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.linkedSet.data.LinkedSetDetailsContainerVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class LinkedSetDetailsContainerViewMeta extends AbstractView
   {
       
      
      public var closeView:Function;
      
      private var _linkedSetDetailsContainerVO:LinkedSetDetailsContainerVO;
      
      public function LinkedSetDetailsContainerViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._linkedSetDetailsContainerVO)
         {
            this._linkedSetDetailsContainerVO.dispose();
            this._linkedSetDetailsContainerVO = null;
         }
         super.onDispose();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:LinkedSetDetailsContainerVO = this._linkedSetDetailsContainerVO;
         this._linkedSetDetailsContainerVO = new LinkedSetDetailsContainerVO(param1);
         this.setInitData(this._linkedSetDetailsContainerVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:LinkedSetDetailsContainerVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
