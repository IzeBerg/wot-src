package net.wg.gui.components.controls.achievements
{
   import flash.events.MouseEvent;
   import net.wg.data.VO.AchievementProfileVO;
   import net.wg.data.constants.AchievementSection;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.battleResults.components.CustomAchievement;
   
   public class AchievementCounter extends CustomAchievement
   {
      
      public static const COUNTER_TYPE_INVALID:String = "cTypeInv";
      
      public static const COUNTER_VALUE_INVALID:String = "cValueInv";
      
      public static const LAYOUT_INVALID:String = "layoutInvalid";
       
      
      protected var counter:CounterComponent;
      
      private var _counterType:String;
      
      private var _oldCounterType:String;
      
      private var _counterValue:String;
      
      private var _profileAchievement:AchievementProfileVO;
      
      public function AchievementCounter()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._profileAchievement = achievement as AchievementProfileVO;
         this.applyData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         loader.mouseChildren = false;
         loader.buttonMode = false;
         this.buttonMode = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(COUNTER_TYPE_INVALID))
         {
            if(this._oldCounterType != this._counterType)
            {
               this._oldCounterType = this._counterType;
               this.disposeCounter();
               if(this._counterType && this._counterType != "")
               {
                  this.counter = App.utils.classFactory.getComponent(this._counterType,CounterComponent);
                  invalidate(LAYOUT_INVALID);
                  invalidate(COUNTER_VALUE_INVALID);
               }
            }
         }
         if(isInvalid(COUNTER_VALUE_INVALID) && this.counter)
         {
            this.counter.text = this._profileAchievement.localizedValue;
            this.counter.validateNow();
            invalidate(LAYOUT_INVALID);
         }
         if(isInvalid(LAYOUT_INVALID))
         {
            this.applyLayoutChanges();
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeCounter();
         this._profileAchievement = null;
         super.onDispose();
      }
      
      override protected function onLoadComplete() : void
      {
         super.onLoadComplete();
         invalidate(LAYOUT_INVALID);
      }
      
      protected function applyLayoutChanges() : void
      {
         if(this.counter && loader.width != 0 && loader.height != 0)
         {
            this.counter.x = loader.x + loader.originalWidth - this.counter.actualWidth ^ 0;
            this.counter.y = loader.y + loader.originalHeight - this.counter.actualHeight - this.counter.receiveBottomPadding() ^ 0;
            addChild(this.counter);
         }
      }
      
      protected function applyData() : void
      {
         if(this._profileAchievement)
         {
            this.counterType = this._profileAchievement.counterType;
            invalidate(COUNTER_VALUE_INVALID);
         }
      }
      
      protected function showToolTip() : void
      {
         if(this._profileAchievement)
         {
            if(this._profileAchievement.name == AchievementSection.MARK_OF_MASTERY)
            {
               App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.MARK_OF_MASTERY,null,this._profileAchievement.block,this._profileAchievement.name,this._profileAchievement.value,this._profileAchievement.vehicleLevel,this._profileAchievement.arenaType);
            }
            else if(this._profileAchievement.name == AchievementSection.MARKS_ON_GUN)
            {
               App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.MARKS_ON_GUN_ACHIEVEMENT,null,achievement.dossierType,this._profileAchievement.dossierCompDescr,this._profileAchievement.block,this._profileAchievement.name,this._profileAchievement.isRare,this._profileAchievement.isDossierForCurrentUser,this._profileAchievement.vehicleLevel,this._profileAchievement.arenaType);
            }
            else
            {
               App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACHIEVEMENT,null,this._profileAchievement.dossierType,this._profileAchievement.dossierCompDescr,this._profileAchievement.block,this._profileAchievement.name,this._profileAchievement.isRare,this._profileAchievement.isDossierForCurrentUser,this._profileAchievement.vehicleLevel,this._profileAchievement.arenaType);
            }
         }
      }
      
      private function disposeCounter() : void
      {
         if(this.counter && contains(this.counter))
         {
            removeChild(this.counter);
            this.counter = null;
         }
      }
      
      public function get counterType() : String
      {
         return this._counterType;
      }
      
      public function set counterType(param1:String) : void
      {
         if(this._counterType != param1)
         {
            this._counterType = param1;
            invalidate(COUNTER_TYPE_INVALID);
         }
      }
      
      public function get counterValue() : String
      {
         return this._counterValue;
      }
      
      public function set counterValue(param1:String) : void
      {
         this._counterValue = param1;
         invalidate(COUNTER_VALUE_INVALID);
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.showToolTip();
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
   }
}
