package net.wg.white_tiger.gui.lobby.battleQueue.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.BossQuickStartPanelVO;
   import net.wg.white_tiger.gui.lobby.battleQueue.data.QuickStartPanelVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class QuickStartBossContent extends QuickStartContentBase
   {
      
      protected static const WIDTH:int = 616;
      
      protected static const HEIGHT:int = 142;
      
      private static const BONUS_TF_NAME:String = "bonusTF";
      
      private static const GAP:int = 4;
      
      private static const BONUS_MC_OFFSET_X:int = 12;
      
      private static const BONUS_MC_OFFSET_Y:int = -15;
       
      
      public var bonusMc:MovieClip = null;
      
      public var ticketMc:MovieClip = null;
      
      public var ticketText:TextField = null;
      
      private var _bonusTF:TextField = null;
      
      private var _data:BossQuickStartPanelVO = null;
      
      public function QuickStartBossContent()
      {
         super();
         setSize(WIDTH,HEIGHT);
      }
      
      override public function setData(param1:QuickStartPanelVO) : void
      {
         this._data = BossQuickStartPanelVO(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.bonusMc = null;
         this.ticketMc = null;
         this.ticketText = null;
         this._bonusTF = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.ticketText.text = EVENT.BATTLEQUEUE_WIDGET_TICKETTEXT;
         App.utils.commons.updateTextFieldSize(this.ticketText);
         this._bonusTF = this.bonusMc.getChildByName(BONUS_TF_NAME) as TextField;
         if(this._bonusTF)
         {
            this._bonusTF.text = EVENT.BATTLEQUEUE_WIDGET_BONUS;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         super.draw();
         if(this._data)
         {
            _loc1_ = this.isBonus;
            if(isInvalid(InvalidationType.DATA))
            {
               _loc2_ = App.utils.locale.makeString(EVENT.BATTLEQUEUE_WIDGET_CHANGETITLE,{"vehicle":this._data.vehName});
               _loc3_ = App.utils.locale.makeString(EVENT.BATTLEQUEUE_WIDGET_BTNLABEL,{"vehicle":this._data.vehName});
               infoText.text = _loc2_;
               App.utils.commons.updateTextFieldSize(infoText);
               quickStartBtn.label = _loc3_;
               this.ticketMc.visible = this.ticketText.visible = !_loc1_;
               this.bonusMc.visible = _loc1_;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               infoText.x = _width - infoText.textWidth >> 1;
               quickStartBtn.x = _width - quickStartBtn.width >> 1;
               if(!_loc1_)
               {
                  _loc4_ = this.ticketText.textWidth + this.ticketMc.width + GAP;
                  this.ticketText.x = width - _loc4_ >> 1;
                  this.ticketMc.x = this.ticketText.x + this.ticketText.textWidth + GAP | 0;
               }
               else
               {
                  this.bonusMc.x = width - this.bonusMc.width + BONUS_MC_OFFSET_X | 0;
                  this.bonusMc.y = BONUS_MC_OFFSET_Y;
               }
            }
         }
      }
      
      override public function get selectedVehId() : int
      {
         if(this._data)
         {
            return this._data.vehID;
         }
         return Values.DEFAULT_INT;
      }
      
      public function get isBonus() : Boolean
      {
         return this._data && this._data.isBonus;
      }
   }
}
