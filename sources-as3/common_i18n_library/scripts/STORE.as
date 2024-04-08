package
{
   public class STORE
   {
      
      public static const SELLCONFIRMATIONPOPOVER_TITLELABEL:String = "#store:sellConfirmationPopover/titleLabel";
      
      public static const SELLCONFIRMATIONPOPOVER_PRICELABEL:String = "#store:sellConfirmationPopover/priceLabel";
      
      public static const RENTALTERMSELECTIONPOPOVER_TITLELABEL:String = "#store:rentalTermSelectionPopover/titleLabel";
      
      public static const RENTALTERMSELECTIONPOPOVER_TERMSLOT3DAYS:String = "#store:rentalTermSelectionPopover/termSlot3Days";
      
      public static const RENTALTERMSELECTIONPOPOVER_TERMSLOT7DAYS:String = "#store:rentalTermSelectionPopover/termSlot7Days";
      
      public static const RENTALTERMSELECTIONPOPOVER_TERMSLOT30DAYS:String = "#store:rentalTermSelectionPopover/termSlot30Days";
      
      public static const RENTALTERMSELECTIONPOPOVER_TERMSLOTANY:String = "#store:rentalTermSelectionPopover/termSlotAny";
      
      public static const RENTALTERMSELECTIONPOPOVER_TERMSLOTSEASON_EPICSEASON:String = "#store:rentalTermSelectionPopover/termSlotSeason/epicSeason";
      
      public static const RENTALTERMSELECTIONPOPOVER_TERMSLOTSEASON_EPICCYCLE:String = "#store:rentalTermSelectionPopover/termSlotSeason/epicCycle";
      
      public static const RENTALTERMSELECTIONPOPOVER_TERMSLOTSEASON_RANKEDSEASON:String = "#store:rentalTermSelectionPopover/termSlotSeason/rankedSeason";
      
      public static const RENTALTERMSELECTIONPOPOVER_TERMSLOTSEASON_RANKEDCYCLE:String = "#store:rentalTermSelectionPopover/termSlotSeason/rankedCycle";
      
      public static const RENTALTERMSELECTIONPOPOVER_TERMSLOTUNLIM:String = "#store:rentalTermSelectionPopover/termSlotUnlim";
      
      public static const CONGRATULATIONANIM_BUYINGLABEL:String = "#store:congratulationAnim/buyingLabel";
      
      public static const CONGRATULATIONANIM_DESCRIPTIONLABEL_STYLE:String = "#store:congratulationAnim/descriptionLabel/style";
      
      public static const CONGRATULATIONANIM_CONFIRMLABEL:String = "#store:congratulationAnim/confirmLabel";
      
      public static const CONGRATULATIONANIM_BACKLABEL:String = "#store:congratulationAnim/backLabel";
      
      public static const CONGRATULATIONANIM_COLLECTIBLELABEL:String = "#store:congratulationAnim/collectibleLabel";
      
      public static const CONGRATULATIONANIM_RESTORELABEL:String = "#store:congratulationAnim/restoreLabel";
      
      public static const CONGRATULATIONANIM_SHOWPREVIEWBTNLABEL:String = "#store:congratulationAnim/showPreviewBtnLabel";
      
      public static const RENTALTERMSELECTIONPOPOVER_TERMSLOTALLDAYS_ENUM:Array = [RENTALTERMSELECTIONPOPOVER_TERMSLOT3DAYS,RENTALTERMSELECTIONPOPOVER_TERMSLOT7DAYS,RENTALTERMSELECTIONPOPOVER_TERMSLOT30DAYS];
       
      
      public function STORE()
      {
         super();
      }
      
      public static function getRentTermDays(param1:String) : String
      {
         var _loc2_:String = "#store:" + "rentalTermSelectionPopover/termSlot" + param1 + "Days";
         if(RENTALTERMSELECTIONPOPOVER_TERMSLOTALLDAYS_ENUM.indexOf(_loc2_) == -1)
         {
            DebugUtils.LOG_WARNING("[getRentTermDays]:locale key \"" + _loc2_ + "\" was not found");
            return null;
         }
         return _loc2_;
      }
   }
}
