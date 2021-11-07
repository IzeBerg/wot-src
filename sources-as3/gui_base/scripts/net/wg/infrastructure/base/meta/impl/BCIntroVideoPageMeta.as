package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.bootcamp.introVideoPage.data.BCIntroVideoVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BCIntroVideoPageMeta extends AbstractView
   {
       
      
      public var videoStarted:Function;
      
      public var videoFinished:Function;
      
      public var goToBattle:Function;
      
      public var skipBootcamp:Function;
      
      public var handleError:Function;
      
      public var onHighlightShow:Function;
      
      private var _bCIntroVideoVO:BCIntroVideoVO;
      
      public function BCIntroVideoPageMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._bCIntroVideoVO)
         {
            this._bCIntroVideoVO.dispose();
            this._bCIntroVideoVO = null;
         }
         super.onDispose();
      }
      
      public function videoStartedS() : void
      {
         App.utils.asserter.assertNotNull(this.videoStarted,"videoStarted" + Errors.CANT_NULL);
         this.videoStarted();
      }
      
      public function videoFinishedS() : void
      {
         App.utils.asserter.assertNotNull(this.videoFinished,"videoFinished" + Errors.CANT_NULL);
         this.videoFinished();
      }
      
      public function goToBattleS() : void
      {
         App.utils.asserter.assertNotNull(this.goToBattle,"goToBattle" + Errors.CANT_NULL);
         this.goToBattle();
      }
      
      public function skipBootcampS() : void
      {
         App.utils.asserter.assertNotNull(this.skipBootcamp,"skipBootcamp" + Errors.CANT_NULL);
         this.skipBootcamp();
      }
      
      public function handleErrorS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.handleError,"handleError" + Errors.CANT_NULL);
         this.handleError(param1);
      }
      
      public function onHighlightShowS() : void
      {
         App.utils.asserter.assertNotNull(this.onHighlightShow,"onHighlightShow" + Errors.CANT_NULL);
         this.onHighlightShow();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:BCIntroVideoVO = this._bCIntroVideoVO;
         this._bCIntroVideoVO = new BCIntroVideoVO(param1);
         this.setData(this._bCIntroVideoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:BCIntroVideoVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
