package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.intro.IntroInfoVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class IntroPageMeta extends AbstractView
   {
       
      
      public var stopVideo:Function;
      
      public var handleError:Function;
      
      private var _introInfoVO:IntroInfoVO;
      
      public function IntroPageMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._introInfoVO)
         {
            this._introInfoVO.dispose();
            this._introInfoVO = null;
         }
         super.onDispose();
      }
      
      public function stopVideoS() : void
      {
         App.utils.asserter.assertNotNull(this.stopVideo,"stopVideo" + Errors.CANT_NULL);
         this.stopVideo();
      }
      
      public function handleErrorS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.handleError,"handleError" + Errors.CANT_NULL);
         this.handleError(param1);
      }
      
      public final function as_playVideo(param1:Object) : void
      {
         var _loc2_:IntroInfoVO = this._introInfoVO;
         this._introInfoVO = new IntroInfoVO(param1);
         this.playVideo(this._introInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function playVideo(param1:IntroInfoVO) : void
      {
         var _loc2_:String = "as_playVideo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
