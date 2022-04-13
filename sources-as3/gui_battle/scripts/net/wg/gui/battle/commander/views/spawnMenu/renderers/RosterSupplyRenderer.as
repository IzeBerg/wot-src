package net.wg.gui.battle.commander.views.spawnMenu.renderers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.RTS_SPAWN_MENU_ENTRY_TYPES;
   import net.wg.gui.battle.commander.views.spawnMenu.VO.RosterSupplyVO;
   
   public class RosterSupplyRenderer extends BaseRosterRenderer
   {
      
      private static const _DEFAULT_COUNT_TEXT_COLOR:uint = 16777215;
      
      private static const _SETTLED_COUNT_TEXT_COLOR:uint = 8442938;
      
      private static const _COUNT_DELIMITER:String = " / ";
      
      private static const _GREEN_COLOR_STATE:String = "_green";
      
      private static const _WHITE_COLOR_STATE:String = "_white";
       
      
      public var countTF:TextField = null;
      
      public var supplyType:MovieClip = null;
      
      public function RosterSupplyRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.countTF = null;
         this.supplyType = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this.supplyData.totalCount - this.supplyData.settledCount;
            _loc2_ = _loc1_ + _COUNT_DELIMITER + this.supplyData.totalCount;
            if(!isAllyRenderer)
            {
               _loc2_ = this.supplyData.totalCount.toString();
            }
            this.countTF.text = _loc2_;
            this.countTF.textColor = !!this.supplyData.isSettled ? uint(_SETTLED_COUNT_TEXT_COLOR) : uint(_DEFAULT_COUNT_TEXT_COLOR);
         }
         if(isInvalid(_INVALID_STAGE | InvalidationType.DATA | InvalidationType.STATE))
         {
            if(!isAllyRenderer)
            {
               this.supplyType.gotoAndStop(roosterData.vehicleType + _WHITE_COLOR_STATE);
            }
            else
            {
               _loc3_ = !!this.supplyData.isSettled ? _GREEN_COLOR_STATE : _WHITE_COLOR_STATE;
               this.supplyType.gotoAndStop(roosterData.vehicleType + _loc3_);
            }
            background.visible = isAllyRenderer;
         }
      }
      
      override public function get itemID() : String
      {
         return this.supplyData.vehicleType;
      }
      
      override public function get entryType() : int
      {
         return RTS_SPAWN_MENU_ENTRY_TYPES.SUPPLY;
      }
      
      public function get supplyData() : RosterSupplyVO
      {
         return data as RosterSupplyVO;
      }
      
      override protected function get canSelect() : Boolean
      {
         return super.canSelect && isAllyRenderer;
      }
      
      override public function get isFocused() : Boolean
      {
         return super.isFocused && isAllyRenderer;
      }
      
      override public function get isSelectable() : Boolean
      {
         return super.isSelectable && isAllyRenderer;
      }
   }
}
