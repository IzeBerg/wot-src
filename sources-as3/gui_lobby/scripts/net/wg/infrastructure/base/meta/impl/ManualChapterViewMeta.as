package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.manualChapter.data.ManualChapterContainerVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ManualChapterViewMeta extends AbstractView
   {
       
      
      public var closeView:Function;
      
      public var bootcampButtonClicked:Function;
      
      private var _manualChapterContainerVO:ManualChapterContainerVO;
      
      public function ManualChapterViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._manualChapterContainerVO)
         {
            this._manualChapterContainerVO.dispose();
            this._manualChapterContainerVO = null;
         }
         super.onDispose();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function bootcampButtonClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.bootcampButtonClicked,"bootcampButtonClicked" + Errors.CANT_NULL);
         this.bootcampButtonClicked();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:ManualChapterContainerVO = this._manualChapterContainerVO;
         this._manualChapterContainerVO = new ManualChapterContainerVO(param1);
         this.setInitData(this._manualChapterContainerVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInitData(param1:ManualChapterContainerVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
