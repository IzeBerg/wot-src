package net.wg.gui.battle.views.radialMenu.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class Content extends Sprite implements IDisposable
   {
      
      private static const BACKGROUND_MIN_WIDTH:int = 20;
      
      private static const ADJUSTING_OFFSET_FOR_LEFTSIDE:int = 26;
      
      private static const TEXTFIELD_PADDING:int = 12;
       
      
      public var icons:Icons = null;
      
      public var titleMC:MovieClip = null;
      
      public var keyTF:TextField = null;
      
      public var customButtonIcon:MovieClip = null;
      
      public var keyBackgroundMC:MovieClip = null;
      
      public function Content()
      {
         super();
         TextFieldEx.setNoTranslate(this.keyTF,true);
         this.icons.visible = true;
         this.titleMC.visible = true;
         this.keyTF.visible = true;
         this.keyBackgroundMC.visible = true;
         this.customButtonIcon.visible = true;
      }
      
      public function animateAndSetTitle(param1:String, param2:String) : void
      {
         this.titleMC.gotoAndStop(param2);
         this.titleMC.titleTF.text = param1;
      }
      
      public function setKeyVisibility(param1:Boolean) : void
      {
         this.keyTF.visible = param1;
         this.keyBackgroundMC.visible = param1;
      }
      
      public function setKeyTextAndBackgroundWidth(param1:String) : void
      {
         this.keyTF.text = param1;
         var _loc2_:int = Math.max(this.keyTF.textWidth + TEXTFIELD_PADDING,BACKGROUND_MIN_WIDTH);
         this.keyBackgroundMC.width = this.keyTF.width = _loc2_;
      }
      
      public function setContentsXCoord(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = -this.titleMC.titleTF.textWidth - param1;
         this.titleMC.x = _loc4_;
         this.setKeyXCoord(param2,param3);
      }
      
      public function setKeyXCoord(param1:int, param2:int) : void
      {
         var _loc3_:int = param1;
         if(param1 < 0)
         {
            _loc3_ = param1 - this.keyTF.width + ADJUSTING_OFFSET_FOR_LEFTSIDE;
         }
         this.keyBackgroundMC.x = _loc3_;
         this.keyTF.x = _loc3_;
         this.customButtonIcon.x = param2;
      }
      
      public final function dispose() : void
      {
         if(this.icons != null)
         {
            this.icons.dispose();
         }
         this.icons = null;
         this.titleMC = null;
         this.keyTF = null;
         this.customButtonIcon = null;
         this.keyBackgroundMC = null;
      }
   }
}
