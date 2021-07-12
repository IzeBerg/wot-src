package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.bootcamp.messageWindow.data.MessageContentVO;
   import net.wg.gui.tutorial.windows.TutorialDialog;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BCMessageWindowMeta extends TutorialDialog
   {
       
      
      public var onMessageRemoved:Function;
      
      public var onMessageAppear:Function;
      
      public var onMessageDisappear:Function;
      
      public var onMessageExecuted:Function;
      
      public var onMessageButtonClicked:Function;
      
      public var hideBlur:Function;
      
      private var _vectorMessageContentVO:Vector.<MessageContentVO>;
      
      public function BCMessageWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:MessageContentVO = null;
         if(this._vectorMessageContentVO)
         {
            for each(_loc1_ in this._vectorMessageContentVO)
            {
               _loc1_.dispose();
            }
            this._vectorMessageContentVO.splice(0,this._vectorMessageContentVO.length);
            this._vectorMessageContentVO = null;
         }
         super.onDispose();
      }
      
      public function onMessageRemovedS() : void
      {
         App.utils.asserter.assertNotNull(this.onMessageRemoved,"onMessageRemoved" + Errors.CANT_NULL);
         this.onMessageRemoved();
      }
      
      public function onMessageAppearS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onMessageAppear,"onMessageAppear" + Errors.CANT_NULL);
         this.onMessageAppear(param1);
      }
      
      public function onMessageDisappearS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onMessageDisappear,"onMessageDisappear" + Errors.CANT_NULL);
         this.onMessageDisappear(param1);
      }
      
      public function onMessageExecutedS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onMessageExecuted,"onMessageExecuted" + Errors.CANT_NULL);
         this.onMessageExecuted(param1);
      }
      
      public function onMessageButtonClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.onMessageButtonClicked,"onMessageButtonClicked" + Errors.CANT_NULL);
         this.onMessageButtonClicked();
      }
      
      public function hideBlurS() : void
      {
         App.utils.asserter.assertNotNull(this.hideBlur,"hideBlur" + Errors.CANT_NULL);
         this.hideBlur();
      }
      
      public final function as_setMessageData(param1:Array) : void
      {
         var _loc5_:MessageContentVO = null;
         var _loc2_:Vector.<MessageContentVO> = this._vectorMessageContentVO;
         this._vectorMessageContentVO = new Vector.<MessageContentVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorMessageContentVO[_loc4_] = new MessageContentVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setMessageData(this._vectorMessageContentVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setMessageData(param1:Vector.<MessageContentVO>) : void
      {
         var _loc2_:String = "as_setMessageData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
