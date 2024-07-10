package net.wg.gui.components.questProgress.components.headerProgress
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import scaleform.clik.data.DataProvider;
   
   public class HeaderProgressItemBig extends HeaderProgressItemProgress
   {
      
      private static const CONDITION_GROUP_X:int = -9;
      
      private static const CONDITION_GROUP_Y:int = -8;
      
      private static const CONDITIONS_GAP:int = 4;
      
      private static const SEPARATOR_GAP:int = 9;
      
      private static const HEADER_TF_GAP:int = 11;
       
      
      public var separator:Sprite = null;
      
      private var _conditionGroup:GroupEx = null;
      
      public function HeaderProgressItemBig()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._conditionGroup = new GroupEx();
         this._conditionGroup.itemRendererLinkage = QUEST_PROGRESS_BASE.QP_VIEW_RENDERER_CONDITION_AWARD;
         this._conditionGroup.layout = new HorizontalGroupLayout(CONDITIONS_GAP);
         this._conditionGroup.y = CONDITION_GROUP_Y;
         this.addChild(this._conditionGroup);
      }
      
      override protected function onDataUpdate(param1:IHeaderProgressData, param2:int) : void
      {
         super.onDataUpdate(param1,param2);
         this._conditionGroup.dataProvider = new DataProvider(param1.conditions);
         this._conditionGroup.validateNow();
         valueTitleTf.visible = param1.conditions.length == 1;
         App.utils.commons.updateTextFieldSize(headerTf,true,false);
         var _loc3_:int = headerTf.width + SEPARATOR_GAP + HEADER_TF_GAP + this._conditionGroup.width + CONDITION_GROUP_X;
         if(valueTitleTf.visible)
         {
            _loc3_ += valueTitleTf.width;
         }
         this._conditionGroup.x = _loc3_ < param2 ? Number(CONDITION_GROUP_X + (param2 - _loc3_ >> 1)) : Number(CONDITION_GROUP_X);
         if(valueTitleTf.visible)
         {
            valueTitleTf.x = this._conditionGroup.x + this._conditionGroup.width;
            this.separator.x = valueTitleTf.x + valueTitleTf.width + SEPARATOR_GAP;
         }
         else
         {
            this.separator.x = this._conditionGroup.x + this._conditionGroup.width + SEPARATOR_GAP;
         }
         headerTf.x = this.separator.x + HEADER_TF_GAP;
         if(_loc3_ > param2)
         {
            headerTf.width = param2 - headerTf.x;
            truncatHeaderTf();
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._conditionGroup)
         {
            this._conditionGroup.dispose();
            this._conditionGroup = null;
         }
         this.separator = null;
         super.onDispose();
      }
   }
}
