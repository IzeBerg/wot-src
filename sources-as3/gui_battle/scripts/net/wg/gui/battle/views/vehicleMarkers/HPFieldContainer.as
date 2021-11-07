package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class HPFieldContainer extends Sprite implements IDisposable
   {
       
      
      public var hpFieldWithBar:TextField = null;
      
      public var hpFieldWithoutBar:TextField = null;
      
      public function HPFieldContainer()
      {
         super();
         TextFieldEx.setNoTranslate(this.hpFieldWithBar,true);
         TextFieldEx.setNoTranslate(this.hpFieldWithoutBar,true);
      }
      
      public function dispose() : void
      {
         this.hpFieldWithBar = null;
         this.hpFieldWithoutBar = null;
      }
      
      public function setText(param1:String) : void
      {
         if(this.hpFieldWithBar.visible)
         {
            this.hpFieldWithBar.text = param1;
         }
         else
         {
            this.hpFieldWithoutBar.text = param1;
         }
      }
      
      public function setTextColor(param1:uint) : void
      {
         this.hpFieldWithBar.textColor = param1;
         this.hpFieldWithoutBar.textColor = param1;
      }
      
      public function setWithBarType(param1:Boolean) : void
      {
         this.hpFieldWithBar.visible = param1;
         this.hpFieldWithoutBar.visible = !param1;
      }
   }
}
