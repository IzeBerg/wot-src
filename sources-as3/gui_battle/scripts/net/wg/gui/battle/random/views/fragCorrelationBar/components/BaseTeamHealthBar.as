package net.wg.gui.battle.random.views.fragCorrelationBar.components
{
   import flash.text.TextField;
   import net.wg.data.constants.FragCorrelationBarStatus;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   import scaleform.gfx.TextFieldEx;
   
   public class BaseTeamHealthBar extends BattleUIComponent
   {
      
      private static const HP_BAR_OFFSET_NO_TF_FROM_CENTER:int = 66;
      
      private static const HP_BAR_OFFSET_FROM_CENTER:int = 109;
      
      private static const MIN_RESOLUTION:int = 1128;
      
      private static const REGULAR_BAR_SIZE:int = 234;
      
      private static const MIN_RESOLUTION_BAR_SIZE:int = 174;
       
      
      public var healthTF:TextField = null;
      
      public var hpBar:ScoreHealthBarElement = null;
      
      private var _showHPBar:Boolean = false;
      
      private var _showHPValues:Boolean = false;
      
      private var _healthValue:String = "";
      
      private var _isEnemyBar:Boolean = true;
      
      private var _barWidth:int = -1;
      
      public function BaseTeamHealthBar()
      {
         super();
         TextFieldEx.setNoTranslate(this.healthTF,false);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.POSITION))
         {
            this.healthTF.visible = this._showHPValues;
            if(this._showHPValues)
            {
               this.hpBar.x = !!this._isEnemyBar ? Number(HP_BAR_OFFSET_FROM_CENTER) : Number(-HP_BAR_OFFSET_FROM_CENTER);
            }
            else
            {
               this.hpBar.x = !!this._isEnemyBar ? Number(HP_BAR_OFFSET_NO_TF_FROM_CENTER) : Number(-HP_BAR_OFFSET_NO_TF_FROM_CENTER);
            }
            this.hpBar.setWidth(this._barWidth);
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._showHPValues)
            {
               this.healthTF.text = this._healthValue;
            }
            this.hpBar.visible = this._showHPBar;
         }
      }
      
      override protected function onDispose() : void
      {
         this.healthTF = null;
         this.hpBar.dispose();
         this.hpBar = null;
         super.onDispose();
      }
      
      public function getHealthBarWidth() : int
      {
         return this._barWidth;
      }
      
      public function init(param1:Boolean, param2:Boolean) : void
      {
         this._isEnemyBar = param1;
         this.hpBar.setColor(param1,param2);
         invalidatePosition();
      }
      
      public function setHealthValue(param1:String, param2:int) : void
      {
         this._healthValue = param1;
         this.hpBar.setHealth(param2);
         invalidateData();
      }
      
      public function setViewSettings(param1:int) : void
      {
         var _loc2_:Boolean = FragCorrelationBarStatus.isShowTeamHPBar(param1);
         var _loc3_:Boolean = FragCorrelationBarStatus.isShowTeamHPValues(param1);
         if(_loc3_ == this._showHPValues && _loc2_ == this._showHPBar)
         {
            return;
         }
         this._showHPValues = _loc3_;
         this._showHPBar = _loc2_;
         invalidatePosition();
         invalidateData();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         if(param1 < MIN_RESOLUTION)
         {
            this._barWidth = MIN_RESOLUTION_BAR_SIZE;
         }
         else
         {
            this._barWidth = REGULAR_BAR_SIZE;
         }
         invalidatePosition();
      }
   }
}
