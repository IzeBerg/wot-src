package net.wg.gui.lobby.vehicleTradeWnds.sell
{
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.Colors;
   import net.wg.data.constants.Fonts;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.utils.VehicleSellDialogMoneyVO;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.utils.VehicleSellDialogUtils;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class TotalResult extends UIComponentEx
   {
      
      private static const PADDING_NEXT_BLOCK:int = 25;
      
      private static const RIGHT_POSITION:int = 263;
      
      private static const GAP:int = 40;
       
      
      public var headerTF:TextField;
      
      private var _icon:Vector.<IconText>;
      
      private var _money:Vector.<VehicleSellDialogMoneyVO>;
      
      public function TotalResult()
      {
         this._icon = new Vector.<IconText>(0);
         super();
      }
      
      override protected function configUI() : void
      {
         this.headerTF.text = DIALOGS.VEHICLESELLDIALOG_COMMONRESULT;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IconText = null;
         this.headerTF = null;
         while(this._icon.length > 0)
         {
            _loc1_ = this._icon.pop();
            removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._icon = null;
         if(this._money)
         {
            this._money.splice(0,this._money.length);
            this._money = null;
         }
         super.onDispose();
      }
      
      public function getSize() : int
      {
         return this.headerTF.y + this.headerTF.height + PADDING_NEXT_BLOCK;
      }
      
      public function setMoney(param1:Vector.<VehicleSellDialogMoneyVO>) : void
      {
         this._money = param1;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:IconText = null;
         var _loc4_:VehicleSellDialogMoneyVO = null;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc5_ = 0;
            _loc6_ = RIGHT_POSITION;
            _loc1_ = this._icon.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               removeChild(this._icon[_loc2_]);
               _loc2_++;
            }
            if(this._money != null)
            {
               _loc1_ = this._money.length;
               _loc2_ = 0;
               while(_loc2_ < _loc1_)
               {
                  _loc4_ = this._money[_loc2_];
                  if(_loc5_ < this._icon.length)
                  {
                     _loc3_ = this._icon[_loc5_];
                  }
                  else
                  {
                     _loc3_ = App.utils.classFactory.getComponent(Linkages.ICON_TEXT,IconText);
                     _loc3_.textSize = 14;
                     _loc3_.textFont = Fonts.FIELD_FONT;
                     _loc3_.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
                     this._icon.push(_loc3_);
                  }
                  _loc5_++;
                  _loc3_.iconPosition = _loc3_.textAlign = TextFormatAlign.RIGHT;
                  _loc3_.text = VehicleSellDialogUtils.getCost(_loc4_.value,_loc4_.type);
                  _loc3_.icon = _loc4_.type;
                  if(!_loc4_.hasEnough)
                  {
                     _loc3_.textColor = Colors.ERROR_COLOR;
                  }
                  else
                  {
                     _loc3_.textColor = _loc4_.color;
                  }
                  addChild(_loc3_);
                  _loc3_.validateNow();
                  _loc3_.x = _loc6_;
                  _loc6_ -= _loc3_.getVisibleWidth() + GAP;
                  _loc2_++;
               }
            }
         }
      }
   }
}
