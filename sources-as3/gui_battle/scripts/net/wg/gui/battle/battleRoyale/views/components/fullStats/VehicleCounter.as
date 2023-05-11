package net.wg.gui.battle.battleRoyale.views.components.fullStats
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.battleRoyale.data.VehicleCounterVO;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleCounter extends Sprite implements IDisposable
   {
      
      private static const COUNTER_TEXT_SIZE_SMALL:uint = 28;
      
      private static const DESCRIPTION_TEXT_SIZE_SMALL:uint = 24;
      
      private static const COUNTER_TF_Y_SMALL:uint = 0;
      
      private static const DESCRIPTION_TF_Y_SMALL:uint = 5;
      
      private static const ICON_Y_SMALL:uint = 11;
      
      private static const SQUAD_TF_Y_SMALL:uint = 36;
       
      
      public var counterTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var icon:BattleAtlasSprite = null;
      
      public var squadsTF:TextField = null;
      
      private var _textFormat:TextFormat = null;
      
      private var _counterDefaultTextSize:Object;
      
      private var _descriptionDefaultTextSize:Object;
      
      private var _counterDefaultY:int;
      
      private var _descriptionDefaultY:int;
      
      private var _squadDefaultY:int;
      
      private var _iconDefaultY:int;
      
      private var _isSquad:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function VehicleCounter()
      {
         super();
         this._textFormat = new TextFormat();
         this._counterDefaultTextSize = this.counterTF.defaultTextFormat.size;
         this._descriptionDefaultTextSize = this.descriptionTF.defaultTextFormat.size;
         this._counterDefaultY = this.counterTF.y;
         this._descriptionDefaultY = this.descriptionTF.y;
         this._squadDefaultY = this.squadsTF.y;
         this._iconDefaultY = this.icon.y;
         this.counterTF.autoSize = this.descriptionTF.autoSize = this.squadsTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.counterTF = null;
         this.descriptionTF = null;
         this.icon = null;
         this.squadsTF = null;
         this._textFormat = null;
      }
      
      public function setData(param1:VehicleCounterVO) : void
      {
         this.update(param1.count,param1.squads);
         this.descriptionTF.text = param1.description;
         this.icon.imageName = param1.icon;
      }
      
      public function update(param1:int, param2:String = "") : void
      {
         this.counterTF.text = String(param1);
         this.squadsTF.visible = this._isSquad = param2 != Values.EMPTY_STR;
         if(this._isSquad)
         {
            this.squadsTF.text = param2;
         }
      }
      
      private function updateTfSizeAndPosY(param1:TextField, param2:Object, param3:int) : void
      {
         this._textFormat.size = param2;
         param1.defaultTextFormat = this._textFormat;
         param1.setTextFormat(this._textFormat);
         param1.y = param3;
      }
      
      public function set useSmallLayout(param1:Boolean) : void
      {
         if(param1)
         {
            this.icon.y = ICON_Y_SMALL;
            this.squadsTF.y = SQUAD_TF_Y_SMALL;
            this.updateTfSizeAndPosY(this.counterTF,COUNTER_TEXT_SIZE_SMALL,COUNTER_TF_Y_SMALL);
            this.updateTfSizeAndPosY(this.descriptionTF,DESCRIPTION_TEXT_SIZE_SMALL,DESCRIPTION_TF_Y_SMALL);
         }
         else
         {
            this.icon.y = this._iconDefaultY;
            this.squadsTF.y = this._squadDefaultY;
            this.updateTfSizeAndPosY(this.counterTF,this._counterDefaultTextSize,this._counterDefaultY);
            this.updateTfSizeAndPosY(this.descriptionTF,this._descriptionDefaultTextSize,this._descriptionDefaultY);
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
