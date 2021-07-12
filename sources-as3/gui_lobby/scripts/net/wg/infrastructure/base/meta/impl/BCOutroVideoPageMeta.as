package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.bootcamp.BCOutroVideoVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BCOutroVideoPageMeta extends AbstractView
   {
       
      
      public var videoFinished:Function;
      
      public var handleError:Function;
      
      private var _bCOutroVideoVO:BCOutroVideoVO;
      
      public function BCOutroVideoPageMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._bCOutroVideoVO)
         {
            this._bCOutroVideoVO.dispose();
            this._bCOutroVideoVO = null;
         }
         super.onDispose();
      }
      
      public function videoFinishedS() : void
      {
         App.utils.asserter.assertNotNull(this.videoFinished,"videoFinished" + Errors.CANT_NULL);
         this.videoFinished();
      }
      
      public function handleErrorS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.handleError,"handleError" + Errors.CANT_NULL);
         this.handleError(param1);
      }
      
      public final function as_playVideo(param1:Object) : void
      {
         var _loc2_:BCOutroVideoVO = this._bCOutroVideoVO;
         this._bCOutroVideoVO = new BCOutroVideoVO(param1);
         this.playVideo(this._bCOutroVideoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function playVideo(param1:BCOutroVideoVO) : void
      {
         var _loc2_:String = "as_playVideo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
