package net.wg.gui.battle.views.damageInfoPanel.components
{
   import flash.display.BitmapData;
   import net.wg.data.constants.generated.DAMAGE_INFO_PANEL_CONSTS;
   
   public class TrackDamageItem extends DamageItem
   {
       
      
      private var _normalBitmapData:BitmapData = null;
      
      private var _hasForcedNormalDisplay:Boolean = false;
      
      public function TrackDamageItem()
      {
         super();
      }
      
      override protected function updateData() : void
      {
         if(stateId == DAMAGE_INFO_PANEL_CONSTS.NORMAL)
         {
            if(!this._hasForcedNormalDisplay)
            {
               visible = false;
               return;
            }
            setBitmapDataToElement(this._normalBitmapData);
         }
         else if(stateId == DAMAGE_INFO_PANEL_CONSTS.DAMAGED)
         {
            setBitmapDataToElement(_damagedBitmapData);
         }
         else
         {
            setBitmapDataToElement(_destroyedBitmapData);
         }
         visible = true;
         if(_isHit)
         {
            gotoAndPlay(DAMAGE_INFO_PANEL_CONSTS.HIT_FRAME);
         }
         else
         {
            gotoAndPlay(DAMAGE_INFO_PANEL_CONSTS.SHOW_FRAME);
         }
      }
      
      override protected function onDispose() : void
      {
         this._normalBitmapData.dispose();
         this._normalBitmapData = null;
         super.onDispose();
      }
      
      public function setNormalBitmapData(param1:String) : void
      {
         this._normalBitmapData = getBitmapData(param1);
      }
      
      public function get hasForcedNormalDisplay() : Boolean
      {
         return this._hasForcedNormalDisplay;
      }
      
      public function set hasForcedNormalDisplay(param1:Boolean) : void
      {
         if(this._hasForcedNormalDisplay != param1)
         {
            this._hasForcedNormalDisplay = param1;
            invalidateData();
         }
      }
   }
}
