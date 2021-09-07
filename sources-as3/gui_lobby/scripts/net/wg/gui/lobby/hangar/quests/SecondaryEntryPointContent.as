package net.wg.gui.lobby.hangar.quests
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.hangar.data.SecondaryEntryPointVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SecondaryEntryPointContent extends Sprite implements IDisposable
   {
      
      private static const GOLD_COLOR:int = 15450485;
      
      private static const WHITE_COLOR:int = 16777215;
      
      private static const DISABLED_COLOR:int = 12105912;
       
      
      public var bounds:MovieClip = null;
      
      public var tf:TextField = null;
      
      public var icon:Image = null;
      
      public var flagIcon:Image = null;
      
      public var altIcon:Image = null;
      
      private var _isStyleChosen:Boolean = false;
      
      private var _isEnabled:Boolean = false;
      
      private var _defaultAltIconY:int = 0;
      
      public function SecondaryEntryPointContent()
      {
         super();
         this.altIcon.addEventListener(Event.CHANGE,this.onChangeHandler);
         this.icon.addEventListener(Event.CHANGE,this.onChangeHandler);
         this.altIcon.smoothing = false;
         this._defaultAltIconY = this.altIcon.y;
      }
      
      public final function dispose() : void
      {
         this.bounds = null;
         this.tf = null;
         this.icon.removeEventListener(Event.CHANGE,this.onChangeHandler);
         this.icon.dispose();
         this.icon = null;
         this.flagIcon.dispose();
         this.flagIcon = null;
         this.altIcon.removeEventListener(Event.CHANGE,this.onChangeHandler);
         this.altIcon.dispose();
         this.altIcon = null;
      }
      
      public function setData(param1:SecondaryEntryPointVO) : void
      {
         this._isStyleChosen = param1.is3DStyleChosen;
         this._isEnabled = param1.isEnabled;
         this.tf.text = param1.text;
         this.tf.textColor = !this._isEnabled ? uint(DISABLED_COLOR) : (!!param1.isBought ? uint(GOLD_COLOR) : uint(WHITE_COLOR));
         this.icon.source = param1.icon;
         this.flagIcon.source = param1.flagIcon;
         this.altIcon.source = param1.altIcon;
      }
      
      private function onChangeHandler(param1:Event) : void
      {
         if(!this.icon.ready || !this.altIcon.ready)
         {
            return;
         }
         if(this._isStyleChosen || !this._isEnabled)
         {
            this.altIcon.y = this._defaultAltIconY;
         }
         else
         {
            this.altIcon.y = this.icon.y + (this.icon.height - this.altIcon.height >> 1);
         }
         this.altIcon.x = this.bounds.x + (this.bounds.width - this.altIcon.width >> 1);
      }
   }
}
