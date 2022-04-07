package net.wg.gui.lobby.battlequeue
{
   import net.wg.data.constants.AlignType;
   import net.wg.gui.components.controls.ImageComponent;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class BattleQueue extends BattleQueueBase
   {
      
      private static const MAX_POS_Y:int = 80;
      
      private static const TNK_ICON_OFFSET:int = 16;
      
      private static const RANKED_BATTLE_ICON_BG:String = "ranked";
      
      private static const EMPTY_BATTLE_ICON_BG:String = "empty";
       
      
      public var tankIcon:ImageComponent;
      
      public function BattleQueue()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.x = param1 - this.actualWidth >> 1;
         this.y = Math.min(-parent.y + (param2 - this.actualHeight >> 1),MAX_POS_Y);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tankIcon.tooltipEnabled = false;
         this.tankIcon.horizontalAlign = AlignType.CENTER;
         this.tankIcon.verticalAlign = AlignType.CENTER;
      }
      
      override protected function onDispose() : void
      {
         this.tankIcon.dispose();
         this.tankIcon = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(typeInfo && isInvalid(INV_TYPE_INFO))
         {
            if(StringUtils.isNotEmpty(typeInfo.layoutStr))
            {
               gotoAndStop(typeInfo.layoutStr);
               if(_baseDisposed)
               {
                  return;
               }
               this.updateStage(parent.width,parent.height);
            }
            modeTitle.text = _typeInfo.title;
            _loc1_ = _typeInfo.iconLabel;
            battleIcon.type = _loc1_;
            if(_loc1_.indexOf(RANKED_BATTLE_ICON_BG) != -1)
            {
               battleIconBg.frameLabel = RANKED_BATTLE_ICON_BG;
            }
            else
            {
               battleIconBg.frameLabel = EMPTY_BATTLE_ICON_BG;
            }
            if(_baseDisposed)
            {
               return;
            }
            gameplayTip.text = typeInfo.description;
            additional.htmlText = typeInfo.additional;
            tankLabel.htmlText = typeInfo.tankLabel;
            App.utils.commons.updateTextFieldSize(tankLabel,true,false);
            this.tankIcon.source = typeInfo.tankIcon;
            this.tankIcon.x = tankLabel.x + tankLabel.width + TNK_ICON_OFFSET;
            tankName.text = typeInfo.tankName;
            tankName.x = this.tankIcon.x + TNK_ICON_OFFSET;
            App.utils.commons.updateTextFieldSize(tankName,true,false);
         }
      }
      
      override protected function getBattleQueueTypeInfoVOForData(param1:Object) : BattleQueueTypeInfoVO
      {
         return new BattleQueueTypeInfoVO(param1);
      }
   }
}
