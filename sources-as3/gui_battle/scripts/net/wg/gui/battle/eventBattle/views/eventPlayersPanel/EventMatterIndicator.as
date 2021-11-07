package net.wg.gui.battle.eventBattle.views.eventPlayersPanel
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class EventMatterIndicator extends Sprite implements IDisposable
   {
      
      private static const SOULS_VALUE1:int = 10;
      
      private static const SOULS_VALUE2:int = 100;
      
      private static const SOULS_LABEL_1DIGIT:String = "1digit";
      
      private static const SOULS_LABEL_2DIGIT:String = "2digit";
      
      private static const SOULS_LABEL_3DIGIT:String = "3digit";
       
      
      public var soulsTF:TextField = null;
      
      public var soulsImage:MovieClip = null;
      
      public function EventMatterIndicator()
      {
         super();
         TextFieldEx.setNoTranslate(this.soulsTF,true);
      }
      
      public final function dispose() : void
      {
         this.soulsTF = null;
         this.soulsImage = null;
      }
      
      public function setCount(param1:uint) : void
      {
         this.soulsImage.visible = this.soulsTF.visible = param1 > 0;
         this.soulsTF.text = param1.toString();
         if(param1 < SOULS_VALUE1)
         {
            this.soulsImage.gotoAndStop(SOULS_LABEL_1DIGIT);
         }
         else if(param1 < SOULS_VALUE2)
         {
            this.soulsImage.gotoAndStop(SOULS_LABEL_2DIGIT);
         }
         else
         {
            this.soulsImage.gotoAndStop(SOULS_LABEL_3DIGIT);
         }
      }
   }
}
