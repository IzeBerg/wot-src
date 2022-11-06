package net.wg.gui.components.tooltips
{
   import net.wg.gui.components.interfaces.ICounterComponent;
   import net.wg.gui.components.tooltips.VO.AchievementVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.utils.ILocale;
   
   public class ToolTipMarksOnGun extends ToolTipAchievement
   {
       
      
      public function ToolTipMarksOnGun()
      {
         super();
      }
      
      override protected function getClassInfoText(param1:Number, param2:String, param3:Array) : String
      {
         if(param2 != "")
         {
            return Utils.instance.htmlWrapper(param2,Utils.instance.COLOR_NORMAL,12,"$TextFont");
         }
         return "";
      }
      
      override protected function applyClassParams(param1:AchievementVO, param2:Number) : void
      {
         var _loc7_:ToolTipBlockResultVO = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc3_:ILocale = App.utils.locale;
         var _loc4_:ToolTipBlockVO = new ToolTipBlockVO();
         _loc4_.leftText = "";
         _loc4_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
         _loc4_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
         _loc4_.contener = content;
         _loc4_.startYPos = topPosition;
         _loc4_.childrenNamePrefix = "classParams";
         _loc4_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
         var _loc5_:Utils = Utils.instance;
         var _loc6_:int = 1;
         while(_loc6_ < 4)
         {
            _loc8_ = _loc3_.makeString(ACHIEVEMENTS.MARKSONGUN_DESCR_PARAM_VALUE + "/" + _loc6_);
            _loc4_.leftText += _loc5_.htmlWrapper(_loc8_,_loc5_.COLOR_NUMBER,11,"$TextFont") + "<br>";
            _loc9_ = _loc3_.makeString(ACHIEVEMENTS.MARKSONGUN_DESCR_PARAM_LABEL + "/" + _loc6_);
            _loc4_.rightTextList.push(new ToolTipBlockRightListItemVO(_loc9_,null,-1,4));
            _loc6_++;
         }
         _loc7_ = Utils.instance.createBlock(_loc4_,param2);
         blockResults.push(_loc7_);
         topPosition = _loc7_.startYPos;
         hasIcon = !!_loc7_.hasIcons ? Boolean(true) : Boolean(hasIcon);
         leftPartMaxW = _loc7_.leftPartMaxW > leftPartMaxW ? Number(_loc7_.leftPartMaxW) : Number(leftPartMaxW);
      }
      
      override protected function applyDescriptionParams(param1:String, param2:Number, param3:Number) : void
      {
         var _loc4_:ILocale = App.utils.locale;
         var _loc5_:String = _loc4_.makeString(ACHIEVEMENTS.MARKSONGUNHEADER);
         _loc5_ = "<br/><br/>" + Utils.instance.htmlWrapper(_loc5_,Utils.instance.COLOR_NORMAL,14,"$TitleFont");
         super.applyDescriptionParams(param1 + _loc5_,param2,param3);
      }
      
      override protected function getInfoCounter(param1:String, param2:Number, param3:String, param4:String) : ICounterComponent
      {
         return null;
      }
      
      override protected function getNotAvailableText() : String
      {
         return TOOLTIPS.ACHIEVEMENT_MARKSONGUN_NOTINDOSSIER;
      }
   }
}
