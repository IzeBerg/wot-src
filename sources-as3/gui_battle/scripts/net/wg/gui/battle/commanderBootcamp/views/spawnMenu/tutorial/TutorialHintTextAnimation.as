package net.wg.gui.battle.commanderBootcamp.views.spawnMenu.tutorial
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.utils.ICommons;
   
   public class TutorialHintTextAnimation extends TutorialHintAnimation implements ITutorialHintTextAnimation
   {
       
      
      private var _commons:ICommons;
      
      public function TutorialHintTextAnimation()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override public function setSize(param1:Number, param2:Number = NaN) : void
      {
         var _loc3_:TextField = null;
         var _loc4_:TutorialHintTextAnimationMc = null;
         for each(_loc4_ in animations)
         {
            _loc3_ = _loc4_.hintTextMc.hintTF;
            _loc3_.width = param1;
            this._commons.updateTextFieldSize(_loc3_,true,true);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:TutorialHintTextAnimationMc = null;
         this._commons = null;
         for each(_loc1_ in animations)
         {
            _loc1_.dispose();
         }
         super.onDispose();
      }
      
      public function setText(param1:String) : void
      {
         var _loc2_:TextField = null;
         var _loc4_:TutorialHintTextAnimationMc = null;
         var _loc3_:Number = App.appWidth;
         for each(_loc4_ in animations)
         {
            _loc2_ = _loc4_.hintTextMc.hintTF;
            _loc2_.width = _loc3_;
            _loc2_.htmlText = param1;
            this._commons.updateTextFieldSize(_loc2_,true,true);
         }
      }
      
      public function setTextAlign(param1:String) : void
      {
         var _loc3_:TutorialHintTextAnimationMc = null;
         var _loc2_:TextFormat = new TextFormat();
         _loc2_.align = param1;
         for each(_loc3_ in animations)
         {
            _loc3_.hintTextMc.hintTF.setTextFormat(_loc2_);
         }
      }
      
      override public function get width() : Number
      {
         return hideAnimation.width;
      }
      
      override public function get height() : Number
      {
         return hideAnimation.height;
      }
   }
}
