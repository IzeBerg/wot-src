package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.linkedSet.data.LinkedSetHintsVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class LinkedSetHintsViewMeta extends AbstractView
   {
       
      
      public var closeView:Function;
      
      private var _linkedSetHintsVO:LinkedSetHintsVO;
      
      public function LinkedSetHintsViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._linkedSetHintsVO)
         {
            this._linkedSetHintsVO.dispose();
            this._linkedSetHintsVO = null;
         }
         super.onDispose();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:LinkedSetHintsVO = this._linkedSetHintsVO;
         this._linkedSetHintsVO = new LinkedSetHintsVO(param1);
         this.setData(this._linkedSetHintsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:LinkedSetHintsVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
