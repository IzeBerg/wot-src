package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.data.WaitingQueueWindowVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PvESandboxQueueWindowMeta extends AbstractWindowView
   {
       
      
      public var cancel:Function;
      
      private var _waitingQueueWindowVO:WaitingQueueWindowVO;
      
      public function PvESandboxQueueWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._waitingQueueWindowVO)
         {
            this._waitingQueueWindowVO.dispose();
            this._waitingQueueWindowVO = null;
         }
         super.onDispose();
      }
      
      public function cancelS() : void
      {
         App.utils.asserter.assertNotNull(this.cancel,"cancel" + Errors.CANT_NULL);
         this.cancel();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:WaitingQueueWindowVO = this._waitingQueueWindowVO;
         this._waitingQueueWindowVO = new WaitingQueueWindowVO(param1);
         this.setData(this._waitingQueueWindowVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:WaitingQueueWindowVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
