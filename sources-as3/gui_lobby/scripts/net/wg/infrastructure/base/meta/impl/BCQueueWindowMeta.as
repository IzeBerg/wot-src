package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.bootcamp.queueWindow.data.BCQueueVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BCQueueWindowMeta extends AbstractView
   {
       
      
      public var cancel:Function;
      
      private var _bCQueueVO:BCQueueVO;
      
      public function BCQueueWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._bCQueueVO)
         {
            this._bCQueueVO.dispose();
            this._bCQueueVO = null;
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
         var _loc2_:BCQueueVO = this._bCQueueVO;
         this._bCQueueVO = new BCQueueVO(param1);
         this.setData(this._bCQueueVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:BCQueueVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
