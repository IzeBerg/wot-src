package net.wg.gui.battle.views.damageInfoPanel.components
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class DamageItem extends BattleUIComponent
   {
       
      
      public var switcher:MovieClip = null;
      
      public var switcherEffect:MovieClip = null;
      
      public var stateId:int = 0;
      
      protected var _damagedBitmapData:BitmapData = null;
      
      protected var _destroyedBitmapData:BitmapData = null;
      
      protected var _isHit:Boolean = false;
      
      private var _switcherBitmap:Bitmap;
      
      private var _switcherEffectBitmap:Bitmap;
      
      private var _newXPos:Number = 0;
      
      public function DamageItem()
      {
         this._switcherBitmap = new Bitmap();
         this._switcherEffectBitmap = new Bitmap();
         super();
         this.switcher.addChild(this._switcherBitmap);
         this.switcherEffect.addChild(this._switcherEffectBitmap);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.POSITION))
         {
            x = this._newXPos;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateData();
         }
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.switcher.removeChild(this._switcherBitmap);
         if(this._switcherBitmap.bitmapData)
         {
            this._switcherBitmap.bitmapData.dispose();
            this._switcherBitmap.bitmapData = null;
         }
         this._switcherBitmap = null;
         this.switcher = null;
         this.switcherEffect.removeChild(this._switcherEffectBitmap);
         if(this._switcherEffectBitmap.bitmapData)
         {
            this._switcherEffectBitmap.bitmapData.dispose();
            this._switcherEffectBitmap.bitmapData = null;
         }
         this._switcherEffectBitmap = null;
         this.switcherEffect = null;
         this._damagedBitmapData.dispose();
         this._damagedBitmapData = null;
         this._destroyedBitmapData.dispose();
         this._destroyedBitmapData = null;
         super.onDispose();
      }
      
      protected function updateData() : void
      {
         if(this.stateId == DAMAGE_INFO_PANEL_CONSTS.NORMAL)
         {
            visible = false;
            return;
         }
         if(this.stateId == DAMAGE_INFO_PANEL_CONSTS.DAMAGED)
         {
            this.setBitmapDataToElement(this._damagedBitmapData);
         }
         else
         {
            this.setBitmapDataToElement(this._destroyedBitmapData);
         }
         visible = true;
         if(this._isHit)
         {
            gotoAndPlay(DAMAGE_INFO_PANEL_CONSTS.HIT_FRAME);
         }
         else
         {
            gotoAndPlay(DAMAGE_INFO_PANEL_CONSTS.SHOW_FRAME);
         }
      }
      
      protected function getBitmapData(param1:String) : BitmapData
      {
         return BitmapData(App.utils.classFactory.getObject(param1));
      }
      
      public function setBitmapData(param1:String, param2:String) : void
      {
         this._damagedBitmapData = this.getBitmapData(param1);
         this._destroyedBitmapData = this.getBitmapData(param2);
      }
      
      public function setBitmapDataToElement(param1:BitmapData) : void
      {
         this._switcherBitmap.bitmapData = param1;
         this._switcherEffectBitmap.bitmapData = param1;
      }
      
      public function updateItem(param1:int, param2:Boolean) : void
      {
         this.stateId = param1;
         this._isHit = param2;
         invalidate(InvalidationType.DATA);
      }
      
      public function updateXPos(param1:Number) : void
      {
         if(x != param1)
         {
            this._newXPos = param1;
            invalidate(InvalidationType.POSITION);
         }
      }
   }
}
