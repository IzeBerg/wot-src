package net.wg.gui.battle.views.staticMarkers.flag
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.battle.views.staticMarkers.flag.constant.FlagMarkerState;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class FlagMarker extends Sprite implements IDisposable
   {
       
      
      public var cooldownTF:TextField = null;
      
      public var cooldownBG:DisplayObject = null;
      
      public var labelTF:TextField = null;
      
      public var marker:FlagIcon = null;
      
      private var _state:String = null;
      
      private var _labelText:String = null;
      
      private var _disposed:Boolean = false;
      
      public function FlagMarker()
      {
         super();
         this.cooldownTF.visible = false;
         this.cooldownBG.visible = false;
         this.labelTF.visible = false;
      }
      
      public function setIcon(param1:String) : void
      {
         if(this._state == param1)
         {
            return;
         }
         if(this._state == FlagMarkerState.STATE_COOLDOWN)
         {
            this.cooldownTF.visible = false;
            this.cooldownBG.visible = false;
            this.labelTF.visible = true;
         }
         else if(param1 == FlagMarkerState.STATE_COOLDOWN)
         {
            this.cooldownTF.visible = true;
            this.cooldownBG.visible = true;
            this.labelTF.visible = false;
         }
         this.marker.showMarker(param1);
         this._state = param1;
         if(this._labelText)
         {
            this.applyLabel();
         }
      }
      
      public function setLabel(param1:String) : void
      {
         this._labelText = param1;
         this.applyLabel();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.marker.dispose();
         this.cooldownTF = null;
         this.cooldownBG = null;
         this.labelTF = null;
         this.marker = null;
      }
      
      private function applyLabel() : void
      {
         if(this._state == FlagMarkerState.STATE_COOLDOWN)
         {
            this.cooldownTF.text = this._labelText;
         }
         else
         {
            this.labelTF.text = this._labelText;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
