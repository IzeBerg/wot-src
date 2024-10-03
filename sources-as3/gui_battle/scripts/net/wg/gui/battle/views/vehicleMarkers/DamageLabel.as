package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class DamageLabel extends Sprite implements IDisposable
   {
       
      
      public var green:TextField = null;
      
      public var red:TextField = null;
      
      public var gold:TextField = null;
      
      public var blue:TextField = null;
      
      public var yellow:TextField = null;
      
      public var purple:TextField = null;
      
      public var white:TextField = null;
      
      private var _currentTF:TextField = null;
      
      protected var tfMap:Object;
      
      private var _disposed:Boolean = false;
      
      public function DamageLabel()
      {
         this.tfMap = {};
         super();
         this._currentTF = this.green;
         this.green.visible = false;
         this.red.visible = false;
         this.gold.visible = false;
         this.blue.visible = false;
         this.yellow.visible = false;
         this.purple.visible = false;
         this.white.visible = false;
         TextFieldEx.setNoTranslate(this.green,true);
         TextFieldEx.setNoTranslate(this.red,true);
         TextFieldEx.setNoTranslate(this.gold,true);
         TextFieldEx.setNoTranslate(this.blue,true);
         TextFieldEx.setNoTranslate(this.yellow,true);
         TextFieldEx.setNoTranslate(this.purple,true);
         TextFieldEx.setNoTranslate(this.white,true);
         this.green.autoSize = TextFieldAutoSize.LEFT;
         this.red.autoSize = TextFieldAutoSize.LEFT;
         this.gold.autoSize = TextFieldAutoSize.LEFT;
         this.blue.autoSize = TextFieldAutoSize.LEFT;
         this.yellow.autoSize = TextFieldAutoSize.LEFT;
         this.purple.autoSize = TextFieldAutoSize.LEFT;
         this.white.autoSize = TextFieldAutoSize.LEFT;
         this.tfMap["green"] = this.green;
         this.tfMap["red"] = this.red;
         this.tfMap["gold"] = this.gold;
         this.tfMap["blue"] = this.blue;
         this.tfMap["yellow"] = this.yellow;
         this.tfMap["purple"] = this.purple;
         this.tfMap["white"] = this.white;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         this.green = null;
         this.red = null;
         this.gold = null;
         this.blue = null;
         this.yellow = null;
         this.purple = null;
         this.white = null;
         this._currentTF = null;
         this.tfMap["green"] = null;
         this.tfMap["red"] = null;
         this.tfMap["gold"] = null;
         this.tfMap["blue"] = null;
         this.tfMap["yellow"] = null;
         this.tfMap["purple"] = null;
         this.tfMap["white"] = null;
         this.tfMap = null;
      }
      
      private function showTF(param1:String) : void
      {
         if(this.tfMap[param1])
         {
            this._currentTF.visible = false;
            this._currentTF = this.tfMap[param1];
            this._currentTF.visible = true;
         }
         else
         {
            App.utils.asserter.assert(false,"Can\'t find TextField " + param1 + " in DamageLabel");
         }
      }
      
      public function set color(param1:String) : void
      {
         this.showTF(param1);
      }
      
      public function set text(param1:String) : void
      {
         if(this._currentTF)
         {
            this._currentTF.text = param1;
         }
      }
      
      public function get textWidth() : Number
      {
         return Boolean(this._currentTF) ? Number(this._currentTF.textWidth) : Number(0);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
