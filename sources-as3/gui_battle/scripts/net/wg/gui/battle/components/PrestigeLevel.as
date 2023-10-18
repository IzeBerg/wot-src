package net.wg.gui.battle.components
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import scaleform.gfx.TextFieldEx;
   
   public class PrestigeLevel extends BattleUIComponent
   {
      
      private static const FRAME_LABEL_SEPARATOR:String = "_";
       
      
      public var markIcon:BattleAtlasSprite;
      
      public var levelTF:TextField;
      
      private var _prestigeMarkId:int = -1;
      
      private var _prestigeLevel:int = -1;
      
      public function PrestigeLevel()
      {
         super();
         TextFieldEx.setNoTranslate(this.levelTF,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._prestigeMarkId > 0 && this._prestigeLevel > 0)
            {
               _loc1_ = this._prestigeLevel.toString();
               _loc2_ = this._prestigeMarkId.toString();
               _loc3_ = _loc2_ + FRAME_LABEL_SEPARATOR + _loc1_.length.toString();
               this.gotoAndStop(_loc3_);
               this.levelTF.text = _loc1_;
               this.markIcon.imageName = BATTLEATLAS.getPrestigeMark(_loc2_,_loc1_.length.toString());
               this.markIcon.visible = this.levelTF.visible = true;
            }
            else
            {
               this.markIcon.visible = this.levelTF.visible = false;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.markIcon = null;
         this.levelTF = null;
         super.onDispose();
      }
      
      public function set level(param1:int) : void
      {
         if(param1 == this._prestigeLevel)
         {
            return;
         }
         this._prestigeLevel = param1;
         invalidateData();
      }
      
      public function set markId(param1:int) : void
      {
         if(param1 == this._prestigeMarkId)
         {
            return;
         }
         this._prestigeMarkId = param1;
         invalidateData();
      }
   }
}
