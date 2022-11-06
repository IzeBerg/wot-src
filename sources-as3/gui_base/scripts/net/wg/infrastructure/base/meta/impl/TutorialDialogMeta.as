package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.tutorial.data.TutorialDialogVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class TutorialDialogMeta extends AbstractWindowView
   {
       
      
      public var submit:Function;
      
      public var cancel:Function;
      
      private var _tutorialDialogVO:TutorialDialogVO;
      
      private var _tutorialDialogVO1:TutorialDialogVO;
      
      public function TutorialDialogMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._tutorialDialogVO)
         {
            this._tutorialDialogVO.dispose();
            this._tutorialDialogVO = null;
         }
         if(this._tutorialDialogVO1)
         {
            this._tutorialDialogVO1.dispose();
            this._tutorialDialogVO1 = null;
         }
         super.onDispose();
      }
      
      public function submitS() : void
      {
         App.utils.asserter.assertNotNull(this.submit,"submit" + Errors.CANT_NULL);
         this.submit();
      }
      
      public function cancelS() : void
      {
         App.utils.asserter.assertNotNull(this.cancel,"cancel" + Errors.CANT_NULL);
         this.cancel();
      }
      
      public final function as_setContent(param1:Object) : void
      {
         var _loc2_:TutorialDialogVO = this._tutorialDialogVO;
         this._tutorialDialogVO = new TutorialDialogVO(param1);
         this.setContent(this._tutorialDialogVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateContent(param1:Object) : void
      {
         var _loc2_:TutorialDialogVO = this._tutorialDialogVO1;
         this._tutorialDialogVO1 = new TutorialDialogVO(param1);
         this.updateContent(this._tutorialDialogVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setContent(param1:TutorialDialogVO) : void
      {
         var _loc2_:String = "as_setContent" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateContent(param1:TutorialDialogVO) : void
      {
         var _loc2_:String = "as_updateContent" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
